import Testing
import UIKit
@testable import WooCommerce

@MainActor
struct UIBarAppearanceTests {
    private let lightTraits = UITraitCollection(userInterfaceStyle: .light)

    @Test func test_applyWooAppearance_when_applied_to_tab_bar_then_chrome_is_monochrome() {
        // Given, When
        UITabBar.applyWooAppearance()

        // Then
        #expect(UITabBar.appearance().tintColor?.resolvedColor(with: lightTraits) == UIColor.chromeTint.resolvedColor(with: lightTraits))
        #expect(UITabBar.appearance().unselectedItemTintColor?.resolvedColor(with: lightTraits) == UIColor.textSubtle.resolvedColor(with: lightTraits))
    }

    @Test func test_applyWooAppearance_when_applied_to_navigation_bar_then_bar_buttons_are_monochrome() {
        // Given, When
        UINavigationBar.applyWooAppearance()

        // Then
        #expect(UINavigationBar.appearance().tintColor?.resolvedColor(with: lightTraits) == UIColor.chromeTint.resolvedColor(with: lightTraits))
    }
}
