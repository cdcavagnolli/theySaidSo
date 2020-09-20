import UIKit

class QuoteView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textLabel = UILabel()
    private let authorLabel = UILabel()
    private let topQuotes = UIImageView()
    private let bottomQuotes = UIImageView()
    
    var labelText = String() {
        didSet {
            textLabel.text = labelText
        }
    }
    
    var labelAuthor = String() {
        didSet {
            authorLabel.text = labelAuthor
        }
    }
    
    var quoteImage = String() {
        didSet {
            bottomQuotes.image = UIImage(named: quoteImage)
            topQuotes.image = UIImage(named: quoteImage)
        }
    }
    
    private func setupLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 18, weight: .bold)
        textLabel.textColor = .black
        addSubview(textLabel)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .center
        authorLabel.font = .systemFont(ofSize: 15, weight: .regular)
        authorLabel.textColor = .black
        addSubview(authorLabel)
        
        topQuotes.translatesAutoresizingMaskIntoConstraints = false
        topQuotes.contentMode = .scaleAspectFit
        addSubview(topQuotes)
        
        bottomQuotes.translatesAutoresizingMaskIntoConstraints = false
        bottomQuotes.contentMode = .scaleAspectFit
        bottomQuotes.transform = CGAffineTransform(rotationAngle: .pi)
        addSubview(bottomQuotes)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            
            authorLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            authorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            authorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            topQuotes.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -50),
            topQuotes.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            topQuotes.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            topQuotes.heightAnchor.constraint(equalToConstant: 50),
            
            bottomQuotes.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 50),
            bottomQuotes.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            bottomQuotes.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            bottomQuotes.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
