import SwiftUI

/// Full-bleed editorial promotion at the top of the dashboard, in the merchandising red of the category rail.
///
struct EditorialHeroCardView: View {
    private let viewModel: EditorialHeroCardViewModel
    private let onShopTapped: () -> Void

    init(viewModel: EditorialHeroCardViewModel = EditorialHeroCardViewModel(),
         onShopTapped: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onShopTapped = onShopTapped
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Layout.contentSpacing) {
            Text(viewModel.eyebrow)
                .font(.caption.weight(.semibold))
                .tracking(Layout.eyebrowTracking)
                .foregroundStyle(.white.opacity(Layout.secondaryOpacity))

            Text(viewModel.headline)
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)

            Text(viewModel.subheadline)
                .font(.headline)
                .foregroundStyle(.white.opacity(Layout.secondaryOpacity))

            Button(action: onShopTapped) {
                Text(viewModel.callToAction)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color(.merchandising))
                    .padding(.vertical, Layout.buttonVerticalPadding)
                    .padding(.horizontal, Layout.buttonHorizontalPadding)
                    .background(Capsule().fill(.white))
            }
            .padding(.top, Layout.buttonTopPadding)
            .accessibilityLabel(viewModel.callToActionAccessibilityLabel)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Layout.cardPadding)
        .background(Color(.merchandising))
        .clipShape(RoundedRectangle(cornerRadius: Layout.cornerRadius, style: .continuous))
        .padding(.horizontal, Layout.horizontalInset)
    }
}

private extension EditorialHeroCardView {
    enum Layout {
        static let contentSpacing: CGFloat = 8
        static let cardPadding: CGFloat = 24
        static let cornerRadius: CGFloat = 20
        static let horizontalInset: CGFloat = 16
        static let eyebrowTracking: CGFloat = 1.2
        static let secondaryOpacity: CGFloat = 0.85
        static let buttonVerticalPadding: CGFloat = 10
        static let buttonHorizontalPadding: CGFloat = 20
        static let buttonTopPadding: CGFloat = 8
    }
}

#Preview {
    EditorialHeroCardView(onShopTapped: {})
}
