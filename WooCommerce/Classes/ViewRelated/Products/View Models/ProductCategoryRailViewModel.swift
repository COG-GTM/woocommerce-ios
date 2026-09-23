import Foundation
import Yosemite

/// Builds the merchandising category rail shown above the products list, from the products currently in the list.
///
struct ProductCategoryRailViewModel: Equatable {
    /// A single category card in the rail.
    ///
    struct Item: Equatable {
        let category: ProductCategory
        let productCount: Int

        var title: String {
            category.name
        }

        var subtitle: String {
            String.pluralize(productCount,
                             singular: Localization.singularProductCount,
                             plural: Localization.pluralProductCount)
        }
    }

    let items: [Item]

    /// Categories of the given products, most merchandised first, capped to a browsable number of cards.
    ///
    init(products: [Product], maximumNumberOfItems: Int = Constants.maximumNumberOfItems) {
        var countsByCategoryID: [Int64: Int] = [:]
        var categoriesByID: [Int64: ProductCategory] = [:]

        for product in products {
            for category in product.categories {
                countsByCategoryID[category.categoryID, default: 0] += 1
                categoriesByID[category.categoryID] = category
            }
        }

        let sortedItems = countsByCategoryID
            .compactMap { categoryID, count -> Item? in
                guard let category = categoriesByID[categoryID] else {
                    return nil
                }
                return Item(category: category, productCount: count)
            }
            .sorted { lhs, rhs in
                lhs.productCount == rhs.productCount ?
                lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending :
                lhs.productCount > rhs.productCount
            }

        items = Array(sortedItems.prefix(maximumNumberOfItems))
    }

    var isEmpty: Bool {
        items.isEmpty
    }
}

extension ProductCategoryRailViewModel {
    enum Constants {
        static let maximumNumberOfItems = 8
    }

    enum Localization {
        static let singularProductCount = NSLocalizedString(
            "productCategoryRail.productCount.singular",
            value: "%1$ld product",
            comment: "Number of products in a category card on the products list. Reads like: 1 product"
        )
        static let pluralProductCount = NSLocalizedString(
            "productCategoryRail.productCount.plural",
            value: "%1$ld products",
            comment: "Number of products in a category card on the products list. Reads like: 12 products"
        )
    }
}
