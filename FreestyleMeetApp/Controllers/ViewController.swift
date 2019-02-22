import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItself()
        initLoginView()
        initTextFields()
    }
    
    func initItself() {
        self.view.setBackgroundImage(uiImage: #imageLiteral(resourceName: "ff_main_bg"))
    }
    
    func initLoginView() {
        loginView.clipsToBounds = true
        
        let layer = loginView.layer
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = loginView.frame.size.width / 10
    }
    
    func initTextFields() {
        loginTextField.text = "ibuki.yoshida"
        passwordTextField.text = "password123"
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        guard var login = loginTextField.text, let password = passwordTextField.text,
            !login.isEmpty, !password.isEmpty else {
            self.alert(title: Strings.error, message: Strings.noLoginOrPassword)
            return
        }
        
        login += "@google.jp"
        
        FirebaseHandler.getInstance().authenticate(eMail: login, password: password, onSuccessCallback: {
            let storyboard = UIStoryboard(name: CoreConstants.Storyboards.appStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: CoreConstants.ViewControllers.appNavController) as! AppStoryboardNavigationController
            
            self.fetchMeets(vc)
        }, onErrorCallback: {
            self.alert(title: Strings.error, message: Strings.cannotLogin)
        })
    }
    
    private func fetchMeets(_ vc: AppStoryboardNavigationController) {
        FirebaseHandler.getInstance().getMeets(createItem: { x -> MeetListModel in
            let name = x[CoreConstants.DbKeys.meetName] as! String
            let locationName = x[CoreConstants.DbKeys.meetLocationName] as! String
            let date = x[CoreConstants.DbKeys.meetDate] as! String
            
            return MeetListModel(name: name, locationName: locationName, date: date)
        }, onSuccessCallback: { x in
            vc.meets = x
            self.present(vc, animated: true, completion: nil)
        }, onErrorCallback: {
            self.alert(title: Strings.error, message: Strings.accessDenied)
        })
    }
}

