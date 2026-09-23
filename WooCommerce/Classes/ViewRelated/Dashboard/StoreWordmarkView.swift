import SwiftUI

/// Brand lockup shown at the top of the store dashboard, in place of the plain store name.
///
struct StoreWordmarkView: View {
    /// Read out by assistive technologies, which cannot read the wordmark artwork.
    ///
    let storeName: String

    @ScaledMetric(relativeTo: .subheadline) private var wordmarkHeight = Layout.wordmarkHeight

    var body: some View {
        Image(uiImage: .storeWordmark)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(height: min(wordmarkHeight, Layout.maximumWordmarkHeight))
            .foregroundStyle(Color(.text))
            .accessibilityLabel(storeName)
    }
}

private extension StoreWordmarkView {
    enum Layout {
        static let wordmarkHeight: CGFloat = 18
        static let maximumWordmarkHeight: CGFloat = 32
    }
}

#Preview {
    StoreWordmarkView(storeName: "Nordstrom")
}
