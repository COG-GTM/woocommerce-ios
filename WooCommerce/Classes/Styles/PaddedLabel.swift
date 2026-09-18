import UIKit


// MARK: - PaddedLabel: UILabel subclass that allows for Text Insets.
//
class PaddedLabel: UILabel {

    /// Insets to be applied over the Label's Text.
    ///
    var textInsets = Constants.defaultInsets

    /// When `true`, the label's corners are fully rounded to a capsule shape.
    ///
    var isCapsule = false {
        didSet {
            setNeedsLayout()
        }
    }


    // MARK: - Overridden Methods

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard isCapsule else {
            return
        }

        layer.masksToBounds = true
        layer.cornerCurve = .continuous
        layer.cornerRadius = bounds.height / 2
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += textInsets.top + textInsets.bottom
        intrinsicSuperViewContentSize.width += textInsets.left + textInsets.right
        return intrinsicSuperViewContentSize
    }
}


// MARK: - Constants!
//
private extension PaddedLabel {

    enum Constants {
        static let defaultInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
}
