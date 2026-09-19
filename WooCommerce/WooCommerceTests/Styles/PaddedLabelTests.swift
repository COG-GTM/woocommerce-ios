import Testing
import UIKit
@testable import WooCommerce

@MainActor
struct PaddedLabelTests {

    @Test func test_intrinsic_content_size_when_insets_are_set_then_includes_insets() {
        // Given
        let label = PaddedLabel()
        label.text = "Processing"
        label.textInsets = .zero
        let sizeWithoutInsets = label.intrinsicContentSize

        // When
        label.textInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)

        // Then
        #expect(label.intrinsicContentSize.width == sizeWithoutInsets.width + 20)
        #expect(label.intrinsicContentSize.height == sizeWithoutInsets.height + 8)
    }

    @Test func test_corner_radius_when_capsule_is_enabled_then_is_half_of_height() {
        // Given
        let label = PaddedLabel(frame: CGRect(x: 0, y: 0, width: 120, height: 24))

        // When
        label.isCapsule = true
        label.layoutIfNeeded()

        // Then
        #expect(label.layer.cornerRadius == 12)
        #expect(label.layer.masksToBounds)
    }

    @Test func test_corner_radius_when_capsule_is_disabled_then_is_unchanged() {
        // Given
        let label = PaddedLabel(frame: CGRect(x: 0, y: 0, width: 120, height: 24))
        label.layer.cornerRadius = 4

        // When
        label.layoutIfNeeded()

        // Then
        #expect(label.layer.cornerRadius == 4)
    }

    @Test func test_corner_radius_when_capsule_is_turned_off_then_rounding_is_removed() {
        // Given
        let label = PaddedLabel(frame: CGRect(x: 0, y: 0, width: 120, height: 24))
        label.isCapsule = true
        label.layoutIfNeeded()

        // When
        label.isCapsule = false
        label.layoutIfNeeded()

        // Then
        #expect(label.layer.cornerRadius == 0)
        #expect(label.layer.masksToBounds == false)
        #expect(label.layer.cornerCurve == .circular)
    }
}
