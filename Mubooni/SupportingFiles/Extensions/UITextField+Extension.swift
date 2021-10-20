import UIKit
import Foundation

// MARK: - UITEXTFIELD EXTENSION
extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder ?? "" : "", attributes:[NSAttributedString.Key.foregroundColor: newValue ?? UIColor.black])
        }
    }
}
