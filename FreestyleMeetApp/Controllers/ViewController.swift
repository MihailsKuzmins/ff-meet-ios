import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItself()
        initLoginView()
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
}

