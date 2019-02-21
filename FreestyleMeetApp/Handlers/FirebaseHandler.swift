import Foundation
import Firebase

class FirebaseHandler {
    private static var instance: FirebaseHandler?
    private let db: DatabaseReference!
    
    private init() {
        db = Database.database().reference()
    }
    
    public static func getInstance() -> FirebaseHandler {
        if instance == nil {
            instance = FirebaseHandler()
        }
        
        return instance!
    }
    
    public func authenticate(eMail: String, password: String, onSuccessCallback: @escaping () -> Void, onErrorCallback: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: eMail, password: password) { user, error in
            if let _ = error {
                onErrorCallback()
                return
            }
            
            onSuccessCallback()
        }
    }
    
    func getMeets<T>(createItem: @escaping ([String: Any]) -> T, onSuccessCallback: @escaping ([T]) -> Void, onErrorCallback: @escaping () -> Void) {
        db.child(CoreConstants.DbKeys.meets).observeSingleEvent(of: .value, with: { snapshot in
            let values = snapshot.value as? NSDictionary
            let list = values?.compactMap({ (key, val) -> T in
                let data = val as! Dictionary<String, Any>
                return createItem(data)
            })
            
            if let list = list {
                onSuccessCallback(list)
                return
            }
            
            onErrorCallback()
        }, withCancel: { ex in
            print(ex.localizedDescription)
            onErrorCallback()
        })
    }
}
