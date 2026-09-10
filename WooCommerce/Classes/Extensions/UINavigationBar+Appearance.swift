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
            appearance.tintColor = .accent
            appearance.largeTitleTextAttributes = editorialLargeTitleTextAttributes()
            appearance.compactAppearance = nil
            appearance.scrollEdgeAppearance = editorialTransparentAppearance()
            appearance.compactScrollEdgeAppearance = nil
            return
        }

        let appearance = wooAppearance()
        UINavigationBar.appearance().tintColor = .accent // The color of bar button items in the navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
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

extension UINavigationBarAppearance {
    func removeShadow() {
        shadowImage = nil
        shadowColor = .none
    }
}
