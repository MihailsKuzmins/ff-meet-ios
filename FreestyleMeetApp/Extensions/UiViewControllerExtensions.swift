import Foundation
import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
}
