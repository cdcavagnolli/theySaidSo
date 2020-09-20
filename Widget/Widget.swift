import WidgetKit
import SwiftUI

struct Entry: TimelineEntry {
    var date = Date()
    var quote: Quote
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry {
        return Entry(quote: Quote(text: "N/A", author: "N/A"))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        Service.getQuote { success in
            DispatchQueue.main.async {
                let quote = Quote(text: success.text, author: success.author)
                completion(Entry(quote: quote))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        Service.getQuotes { success in
            var entries = [Entry]()
            DispatchQueue.main.async {
                for index in 0 ..< 50 {
                    let quote = Quote(text: success.quotes[index].text, author: success.quotes[index].author)
                    let date = Calendar.current.date(byAdding: .second, value: index * 3, to: Date())!
                    entries.append(Entry(date: date, quote: quote))
                }
                let timeline = Timeline(entries: entries, policy: .never)
                completion(timeline)
            }
        }
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    var body: some View {
        WidgetView(quote: entry.quote)
    }
}

@main
struct QuoteWidget: Widget {
    private let kind = "Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName(Constants.widgetTitle)
        .description(Constants.widgetDescription)
    }
}
