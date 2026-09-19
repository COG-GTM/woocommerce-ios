import Testing
import Yosemite
@testable import WooCommerce

struct ProductCategoryRailViewModelTests {
    @Test func test_init_when_products_share_categories_then_items_are_deduplicated_with_counts() {
        // Given
        let dresses = makeCategory(categoryID: 1, name: "Dresses")
        let shoes = makeCategory(categoryID: 2, name: "Shoes")
        let products = [makeProduct(productID: 1, categories: [dresses]),
                        makeProduct(productID: 2, categories: [dresses, shoes])]

        // When
        let viewModel = ProductCategoryRailViewModel(products: products)

        // Then
        #expect(viewModel.items.map { $0.title } == ["Dresses", "Shoes"])
        #expect(viewModel.items.map { $0.productCount } == [2, 1])
    }

    @Test func test_init_when_counts_are_tied_then_items_are_sorted_by_name() {
        // Given
        let shoes = makeCategory(categoryID: 1, name: "Shoes")
        let bags = makeCategory(categoryID: 2, name: "Bags")
        let products = [makeProduct(productID: 1, categories: [shoes, bags])]

        // When
        let viewModel = ProductCategoryRailViewModel(products: products)

        // Then
        #expect(viewModel.items.map { $0.title } == ["Bags", "Shoes"])
    }

    @Test func test_init_when_there_are_more_categories_than_the_maximum_then_items_are_capped() {
        // Given
        let categories = (1...10).map { makeCategory(categoryID: Int64($0), name: "Category \($0)") }
        let products = categories.map { makeProduct(productID: $0.categoryID, categories: [$0]) }

        // When
        let viewModel = ProductCategoryRailViewModel(products: products, maximumNumberOfItems: 3)

        // Then
        #expect(viewModel.items.count == 3)
    }

    @Test func test_isEmpty_when_products_have_no_categories_then_returns_true() {
        // Given
        let products = [makeProduct(productID: 1, categories: [])]

        // When
        let viewModel = ProductCategoryRailViewModel(products: products)

        // Then
        #expect(viewModel.isEmpty)
    }

    @Test func test_subtitle_when_category_has_one_product_then_uses_singular_form() {
        // Given
        let products = [makeProduct(productID: 1, categories: [makeCategory(categoryID: 1, name: "Dresses")])]

        // When
        let viewModel = ProductCategoryRailViewModel(products: products)

        // Then
        #expect(viewModel.items.first?.subtitle == "1 product")
    }
}

private extension ProductCategoryRailViewModelTests {
    func makeCategory(categoryID: Int64, name: String) -> ProductCategory {
        ProductCategory(categoryID: categoryID, siteID: 123, parentID: 0, name: name, slug: name.lowercased())
    }

    func makeProduct(productID: Int64, categories: [ProductCategory]) -> Product {
        Product.fake().copy(siteID: 123, productID: productID, categories: categories)
    }
}
