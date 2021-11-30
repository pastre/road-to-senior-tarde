import UIKit

protocol CodedViewLifecycle {
    func addSubviews()
    func constraintSubviews()
    func configureAdditionalSettings()
}

class CodedView: UIView, CodedViewLifecycle {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("iThis view should only be used with ViewCode")
    }
    
    func addSubviews() {
        fatalError("You must override this method!")
    }
    
    func constraintSubviews() {
        fatalError("You must override this method!")
    }
    
    func configureAdditionalSettings() {
        // Op[tional implementation
    }
}

class CodedTableViewCell: UITableViewCell, CodedViewLifecycle {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This view should only be used with ViewCode")
    }
    
    func addSubviews() {
        fatalError("You must override this method!")
    }
    
    func constraintSubviews() {
        fatalError("You must override this method!")
    }
    
    func configureAdditionalSettings() {
        // Optional implementation
    }

}

fileprivate extension CodedViewLifecycle {
    func setupView() {
        addSubviews()
        constraintSubviews()
        configureAdditionalSettings()
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}


extension UIView {
    func layout(@ConstraintBuilder using constraintFactory: (UIView) -> [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintFactory(self))
    }
}

@resultBuilder
struct ConstraintBuilder {
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        components
    }
}

