import UIKit
import Yosemite

/// A horizontally scrolling rail of merchandising category cards, shown above the products list.
///
final class ProductCategoryRailView: UIView {
    /// Called with the category of the tapped card.
    ///
    var onSelectCategory: ((ProductCategory) -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.spacing = Constants.cardSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var categories: [ProductCategory] = []

    init() {
        super.init(frame: .zero)
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: ProductCategoryRailViewModel) {
        isHidden = viewModel.isEmpty
        categories = viewModel.items.map { $0.category }

        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        for (index, item) in viewModel.items.enumerated() {
            stackView.addArrangedSubview(makeCard(for: item, at: index))
        }
    }

    private func configureSubviews() {
        backgroundColor = .clear

        addSubview(scrollView)
        pinSubviewToAllEdges(scrollView)
        scrollView.addSubview(stackView)
        scrollView.pinSubviewToAllEdges(stackView, insets: Constants.contentInsets)

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: Constants.cardHeight),
            scrollView.heightAnchor.constraint(equalToConstant: Constants.cardHeight + Constants.contentInsets.top + Constants.contentInsets.bottom)
        ])
    }

    private func makeCard(for item: ProductCategoryRailViewModel.Item, at index: Int) -> UIView {
        let button = UIButton(type: .system)
        button.tag = index
        button.backgroundColor = .merchandising
        button.layer.cornerRadius = Constants.cardCornerRadius
        button.layer.cornerCurve = .continuous
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(cardTapped(sender:)), for: .touchUpInside)
        button.accessibilityLabel = "\(item.title), \(item.subtitle)"

        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = Constants.cardContentInsets
        configuration.attributedTitle = AttributedString(item.title, attributes: .init([
            .font: UIFont.headline,
            .foregroundColor: UIColor.white
        ]))
        configuration.attributedSubtitle = AttributedString(item.subtitle, attributes: .init([
            .font: UIFont.footnote,
            .foregroundColor: UIColor.white.withAlphaComponent(Constants.subtitleAlpha)
        ]))
        configuration.titleAlignment = .leading
        button.configuration = configuration

        button.widthAnchor.constraint(equalToConstant: Constants.cardWidth).isActive = true
        return button
    }

    @objc private func cardTapped(sender: UIButton) {
        guard let category = categories[safe: sender.tag] else {
            return
        }
        onSelectCategory?(category)
    }
}

private extension ProductCategoryRailView {
    enum Constants {
        static let cardSpacing: CGFloat = 12
        static let cardWidth: CGFloat = 148
        static let cardHeight: CGFloat = 96
        static let cardCornerRadius: CGFloat = 16
        static let subtitleAlpha: CGFloat = 0.8
        static let contentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let cardContentInsets = NSDirectionalEdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 14)
    }
}
