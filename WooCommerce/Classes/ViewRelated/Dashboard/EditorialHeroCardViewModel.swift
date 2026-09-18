import Foundation

/// Copy for the editorial promotion at the top of the dashboard.
///
struct EditorialHeroCardViewModel: Equatable {
    let eyebrow: String
    let headline: String
    let subheadline: String
    let callToAction: String

    init(eyebrow: String = Localization.eyebrow,
         headline: String = Localization.headline,
         subheadline: String = Localization.subheadline,
         callToAction: String = Localization.callToAction) {
        self.eyebrow = eyebrow
        self.headline = headline
        self.subheadline = subheadline
        self.callToAction = callToAction
    }

    /// Reads the whole promotion out at once, so VoiceOver users get the offer before the action.
    ///
    var callToActionAccessibilityLabel: String {
        [headline, subheadline, callToAction].joined(separator: ", ")
    }
}

extension EditorialHeroCardViewModel {
    enum Localization {
        static let eyebrow = NSLocalizedString(
            "editorialHeroCard.eyebrow",
            value: "THIS WEEK",
            comment: "Small label above the promotional headline on the store dashboard"
        )
        static let headline = NSLocalizedString(
            "editorialHeroCard.headline",
            value: "End of Season Clearance",
            comment: "Headline of the promotional card on the store dashboard"
        )
        static let subheadline = NSLocalizedString(
            "editorialHeroCard.subheadline",
            value: "Up to 50% off top finds",
            comment: "Subheadline of the promotional card on the store dashboard"
        )
        static let callToAction = NSLocalizedString(
            "editorialHeroCard.callToAction",
            value: "Shop Top Finds",
            comment: "Button on the promotional card on the store dashboard, opens the products list"
        )
    }
}
