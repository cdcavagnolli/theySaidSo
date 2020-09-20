import Foundation

struct Service {
    static func getQuote(successHandler: @escaping (Quote) -> Void) {
        guard let url = URL(string: Constants.quotesUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                guard let data = data else { return }
                guard let quotes = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [[String: AnyObject]] else { return }
                let quote = quotes.randomElement()
                guard let text = quote?[Constants.text] as? String else { return }
                let author = quote?[Constants.author] as? String
                successHandler(Quote(text: text, author: author ?? Constants.unknowAuthor))
            } catch {
                fatalError()
            }
        })
        dataTask.resume()
    }
    
    static func getQuotes(successHandler: @escaping (Quotes) -> Void) {
        guard let url = URL(string: Constants.quotesUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                guard let data = data else { return }
                guard let quotes = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [[String: AnyObject]] else { return }
                var quotesObject = [Quote]()
                for quote in quotes {
                    guard let text = quote[Constants.text] as? String else { return }
                    let author = quote[Constants.author] as? String
                    quotesObject.append(Quote(text: text, author: author ?? Constants.unknowAuthor))
                }
                successHandler(Quotes(quotes: quotesObject))
            } catch {
                fatalError()
            }
        })
        dataTask.resume()
    }
}
