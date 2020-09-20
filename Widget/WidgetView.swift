import SwiftUI

struct WidgetView: View {
    var quote: Quote
    
    var body: some View {
        ZStack {
            Image(Constants.widgetBackground)
                .resizable().aspectRatio(contentMode: .fill)
            VStack {
                let image = Constants.quoteImage.randomElement()!
                Image(image)
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(height: 20, alignment: .center)
                Text(quote.text)
                    .font(.system(size: 15, weight: .bold))
                    .frame(width: 275, alignment: .center)
                Text(quote.author)
                    .font(.system(size: 12, weight: .regular))
                Image(image)
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(height: 20, alignment: .center)
                    .rotationEffect(.degrees(180))
            }
        }
    }
}

