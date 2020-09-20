import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var quote: Quote?
    
    private var quoteView = QuoteView()
    private var player = AVPlayer()
    private var playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: Constants.background, withExtension: "mov") {
            player = AVPlayer(url: path)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            player.actionAtItemEnd = .none
            playerLayer.frame = view.layer.bounds
            view.layer.insertSublayer(playerLayer, at: 0)
        }
        setupLayout()
    }
    
    private func setupLayout() {
        quoteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteView)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(getQuote))
        quoteView.addGestureRecognizer(gestureRecognizer)
        getQuote()
        
        NSLayoutConstraint.activate([
            quoteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            quoteView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            quoteView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            quoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
    
    @objc private func getQuote() {
        quoteView.isHidden = true
        Service.getQuote { quote in
            self.player.seek(to: .zero) { _ in
                self.player.play()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.quoteView.labelText = quote.text
                self.quoteView.labelAuthor = quote.author
                guard let quoteImage = Constants.quoteImage.randomElement() else { return }
                self.quoteView.quoteImage = quoteImage
                self.quoteView.isHidden = false
            }
        }
    }
}
