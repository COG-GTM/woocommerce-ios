import Testing
import UIKit
@testable import WooCommerce

@MainActor
struct UIFontEditorialTests {
    @Test func test_editorialLargeTitle_is_serif_and_bold() {
        // Given, When
        let font = UIFont.editorialLargeTitle

        // Then
        #expect(font.fontDescriptor.symbolicTraits.contains(.traitBold))
        #expect(font.familyName == UIFont.preferredFont(forTextStyle: .largeTitle).fontDescriptor.withDesign(.serif)
            .map { UIFont(descriptor: $0, size: 0).familyName })
    }

    @Test func test_editorialLargeTitle_matches_large_title_point_size() {
        // Given
        let expectedPointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize

        // When
        let font = UIFont.editorialLargeTitle

        // Then
        #expect(font.pointSize == expectedPointSize)
    }

    @Test func test_editorialLargeTitleTextAttributes_uses_editorial_font() {
        // Given, When
        let attributes = UINavigationBar.editorialLargeTitleTextAttributes()

        // Then
        #expect((attributes[.font] as? UIFont)?.familyName == UIFont.editorialLargeTitle.familyName)
    }
}
