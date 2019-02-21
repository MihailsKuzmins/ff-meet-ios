import Foundation
import UIKit

protocol SegueHandler {
    
    associatedtype Segue: RawRepresentable
    func getIdentifierCase(for segue: UIStoryboardSegue) -> Segue?
}

extension SegueHandler where Self: UIViewController, Segue.RawValue == String {
    
    func getIdentifierCase(for segue: UIStoryboardSegue) -> Segue? {
        guard let identifier = segue.identifier,
            let identifierCase = Segue(rawValue: identifier) else {
                return nil
        }
        return identifierCase
    }
}
