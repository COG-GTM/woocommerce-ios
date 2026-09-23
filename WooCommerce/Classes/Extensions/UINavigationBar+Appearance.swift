import Foundation
import UIKit


// MARK: - UINavigationBar + Woo
//
extension UINavigationBar {

    /// Applies the default WC's Appearance
    ///
    class func applyWooAppearance() {
        if #available(iOS 26.0, *) {
            let appearance = UINavigationBar.appearance()
            appearance.tintColor = .chromeTint
            appearance.largeTitleTextAttributes = editorialLargeTitleTextAttributes()
            appearance.compactAppearance = nil
            appearance.scrollEdgeAppearance = editorialTransparentAppearance()
            appearance.compactScrollEdgeAppearance = nil
            return
        }

        let appearance = wooAppearance()
        UINavigationBar.appearance().tintColor = .chromeTint // The color of bar button items in the navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    /// Large title attributes hold a font resolved for the current content size category, so they go stale
    /// when the preferred text size changes while the app is running. Rebuild them when that happens.
    ///
    class func observeContentSizeCategoryChanges() {
        EditorialLargeTitleObserver.shared.startObserving()
    }

    /// Creates the default WC's Appearance
    ///
    class func wooAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .listForeground(modal: false)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        appearance.largeTitleTextAttributes = editorialLargeTitleTextAttributes()
        return appearance
    }

    /// Editorial treatment for large titles: serif type in the default text color.
    ///
    static func editorialLargeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        [.foregroundColor: UIColor.text, .font: UIFont.editorialLargeTitle]
    }

    /// Editorial large titles over the system's transparent bar background.
    ///
    static func editorialTransparentAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        appearance.largeTitleTextAttributes = editorialLargeTitleTextAttributes()
        return appearance
    }

    /// Applies UIKit's Default Appearance
    ///
    class func applyDefaultAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = nil
        appearance.titleTextAttributes = nil
        appearance.isTranslucent = true
        appearance.tintColor = nil
    }

    /// Removes the shadow from the bar by removing it from all appearances
    ///
    func removeShadow() {
        let updatedSandardAppearance = self.standardAppearance
        updatedSandardAppearance.removeShadow()
        self.standardAppearance = updatedSandardAppearance

        let updatedCompactAppearance = self.compactAppearance ?? UINavigationBar.wooAppearance()
        updatedCompactAppearance.removeShadow()
        self.compactAppearance = updatedCompactAppearance

        let updatedScrollEdgeAppearance = self.scrollEdgeAppearance ?? UINavigationBar.wooAppearance()
        updatedScrollEdgeAppearance.removeShadow()
        self.scrollEdgeAppearance = updatedScrollEdgeAppearance
    }
}

/// Keeps the editorial large title type in step with the preferred content size category.
///
private final class EditorialLargeTitleObserver: NSObject {
    static let shared = EditorialLargeTitleObserver()

    func startObserving() {
        NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contentSizeCategoryDidChange),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }

    @objc private func contentSizeCategoryDidChange() {
        UINavigationBar.applyWooAppearance()
        UINavigationBar.refreshEditorialLargeTitles()
    }
}

private extension UINavigationBar {
    /// Appearance proxy changes only reach navigation bars created afterwards, so update the live ones too.
    ///
    static func refreshEditorialLargeTitles() {
        let attributes = editorialLargeTitleTextAttributes()
        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }

        for navigationBar in windows.flatMap({ navigationBars(in: $0) }) {
            navigationBar.largeTitleTextAttributes = attributes
            let appearances = [navigationBar.standardAppearance,
                               navigationBar.scrollEdgeAppearance,
                               navigationBar.compactAppearance,
                               navigationBar.compactScrollEdgeAppearance].compactMap { $0 }
            for appearance in appearances {
                appearance.largeTitleTextAttributes = attributes
            }
        }
    }

    static func navigationBars(in view: UIView) -> [UINavigationBar] {
        if let navigationBar = view as? UINavigationBar {
            return [navigationBar]
        }

        return view.subviews.flatMap { navigationBars(in: $0) }
    }
}

extension UINavigationBarAppearance {
    func removeShadow() {
        shadowImage = nil
        shadowColor = .none
    }
}
