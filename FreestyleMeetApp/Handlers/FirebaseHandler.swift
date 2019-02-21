import Foundation
import Firebase

class FirebaseHandler {
    private static var instance: FirebaseHandler?
    
    private init() {
        
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
}
