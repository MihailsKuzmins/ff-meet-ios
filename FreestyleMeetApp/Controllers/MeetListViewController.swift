import Foundation
import UIKit

class MeetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SegueHandler {
    @IBOutlet weak var tableView: UITableView!
    private var meets: Array<MeetListModel>?
    private var navController: AppStoryboardNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navController = self.navigationController as? AppStoryboardNavigationController
        meets = navController!.meets
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meets!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoreConstants.CellIdentifiers.MeetTableViewCell, for: indexPath) as! MeetTableViewCell
        let model = meets![indexPath.row]
        
        cell.nameLabel.text = model.name
        cell.locationNameLabel.text = model.locationName
        cell.dateTimeLabel.text = model.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CoreConstants.Ui.meetCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editItem", sender: meets![indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifierCase = self.getIdentifierCase(for: segue) else {
            assertionFailure("Could not map segue identifier for \(segue.identifier ?? "")")
            return
        }

        switch identifierCase {
        case .addItem:
            return
        case .editItem:
            let vc = segue.destination as! MeetReadDetailViewController
            
            
            return
        }
    }
    
    enum Segue: String {
        case addItem
        case editItem
    }
}
