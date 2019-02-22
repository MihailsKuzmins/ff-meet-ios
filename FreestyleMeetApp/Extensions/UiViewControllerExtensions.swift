import Foundation
import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAlertAction(title: Strings.ok, style: .default, handler: nil)
        
        self.present(alert, animated: true)
    }
    
    func confirm(title: String, message: String, onYesCallback: @escaping () -> Void) {
        let confirm = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        confirm.addAlertAction(title: Strings.yes, style: .default, handler: { action in
            onYesCallback()
        })
        confirm.addAlertAction(title: Strings.no, style: .cancel, handler: nil)
        
        self.present(confirm, animated: true)
    }
}
