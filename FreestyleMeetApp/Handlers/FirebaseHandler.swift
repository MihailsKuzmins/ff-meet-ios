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
    
    func getMeets<T>(createItem: @escaping (String, [String: Any]) -> T, onSuccessCallback: @escaping ([T]) -> Void, onErrorCallback: @escaping () -> Void) {
        db.child(CoreConstants.DbKeys.meets).observeSingleEvent(of: .value, with: { snapshot in
            let values = snapshot.value as? NSDictionary
            let list = values?.compactMap({ (key, val) -> T in
                let id = key as! String
                let data = val as! Dictionary<String, Any>
                
                return createItem(id, data)
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
    
    func getMeet(id: String, onSuccessCallback: @escaping ([String: Any]) -> Void, onErrorCallback: @escaping () -> Void) {
        db.child(CoreConstants.DbKeys.meets).child(id).observeSingleEvent(of: .value, with: { snapshot in
            let data = snapshot.value as? [String: Any]
            if let data = data {
                onSuccessCallback(data)
                return
            }
            
            onErrorCallback()
        }, withCancel: { error in
            print(error.localizedDescription)
            onErrorCallback()
        })
    }
}
