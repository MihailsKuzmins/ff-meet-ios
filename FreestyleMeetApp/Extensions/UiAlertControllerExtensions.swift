import Foundation
import UIKit

extension UIAlertController {
    func addAlertAction(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
    }
}
