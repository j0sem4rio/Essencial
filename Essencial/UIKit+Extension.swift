import UIKit
extension UIScrollView {
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
// MARK: - UITableViewCell

extension UITableViewCell {
    func relatedTableView() -> UITableView {
        if let superview = self.superview as? UITableView {
            return superview
        } else if let superview = self.superview?.superview as? UITableView {
            return superview
        } else {
            fatalError("UITableView shall always be found.")
        }
    }
    
    // Fixes multiple color bugs in iPads because of interface builder
    open override var backgroundColor: UIColor? {
        get {
            return backgroundView?.backgroundColor
        }
        set {
            backgroundView?.backgroundColor = backgroundColor
        }
    }
}

// MARK: - UIView

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor? {
        didSet {
            configureView()
        }
    }
    @IBInspectable var bottomColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        configureView()
    }
    
    func configureView() {
        let layer = self.layer as? CAGradientLayer
        let locations = [ 0.0, 1.0 ]
        layer?.locations = locations as [NSNumber]
        let color1 = topColor ?? self.tintColor as UIColor
        let color2 = bottomColor ?? UIColor.black as UIColor
        let colors: [AnyObject] = [ color1.cgColor, color2.cgColor ]
        layer?.colors = colors
    }
    
}
@IBDesignable class CircularView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIView {
    /**
     Remove all constraints from the view.
     */
    func removeConstraints() {
        if let superview = self.superview {
            for constraint in superview.constraints {
                if constraint.firstItem as? UIView == self || constraint.secondItem as? UIView == self {
                    constraint.isActive = false
                }
            }
        }
        for constraint in constraints {
            constraint.isActive = false
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
