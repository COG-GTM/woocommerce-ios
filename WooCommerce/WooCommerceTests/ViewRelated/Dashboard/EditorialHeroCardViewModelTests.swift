import Testing
@testable import WooCommerce

struct EditorialHeroCardViewModelTests {
    @Test func test_default_promotion_copy_is_not_empty() {
        // Given
        let viewModel = EditorialHeroCardViewModel()

        // Then
        #expect(viewModel.eyebrow.isEmpty == false)
        #expect(viewModel.headline.isEmpty == false)
        #expect(viewModel.subheadline.isEmpty == false)
        #expect(viewModel.callToAction.isEmpty == false)
    }

    @Test func test_accessibility_label_reads_the_offer_before_the_action() {
        // Given
        let viewModel = EditorialHeroCardViewModel(eyebrow: "THIS WEEK",
                                                   headline: "End of Season Clearance",
                                                   subheadline: "Up to 50% off top finds",
                                                   callToAction: "Shop Top Finds")

        // When
        let label = viewModel.callToActionAccessibilityLabel

        // Then
        #expect(label == "End of Season Clearance, Up to 50% off top finds, Shop Top Finds")
    }
}
