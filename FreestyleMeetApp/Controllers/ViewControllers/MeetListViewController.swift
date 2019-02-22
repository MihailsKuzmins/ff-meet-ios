import Foundation
import UIKit

class MeetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, SegueHandler {
    @IBOutlet weak var tableView: UITableView!
    private var meets: Array<MeetListModel> = []
    private var navController: AppStoryboardNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMeets()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoreConstants.CellIdentifiers.MeetTableViewCell, for: indexPath) as! MeetTableViewCell
        let model = meets[indexPath.row]
        
        let gestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.deleteMeet(sender:)))
        gestureRecogniser.delegate = self
        cell.addGestureRecognizer(gestureRecogniser)
        
        cell.nameLabel.text = model.name
        cell.locationNameLabel.text = model.locationName
        cell.dateTimeLabel.text = model.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CoreConstants.Ui.meetCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editItem", sender: meets[indexPath.row])
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
            let vc = segue.destination as! MeetDetailReadViewController
            vc.id = (sender as! MeetListModel).id
            return
        }
    }
    
    private func fetchMeets() {
        FirebaseHandler.getInstance().getMeets(createItem: { (key, data) -> MeetListModel in
            let name = data[CoreConstants.DbKeys.meetName] as! String
            let locationName = data[CoreConstants.DbKeys.meetLocationName] as! String
            let date = data[CoreConstants.DbKeys.meetDate] as! String
            
            return MeetListModel(id: key, name: name, locationName: locationName, date: date)
        }, onSuccessCallback: { x in
            self.meets = x
            self.tableView.reloadData()
        }, onErrorCallback: {
            self.alert(title: Strings.error, message: Strings.accessDenied)
        })
    }
    
    @objc private func deleteMeet(sender: UILongPressGestureRecognizer) {
        let touch = sender.location(in: tableView)
        if let indextPath = tableView.indexPathForRow(at: touch) {
            self.confirm(title: Strings.deleteWarning, message: Strings.deleteConfirmation) {
                let id = self.meets[indextPath.row].id
                FirebaseHandler.getInstance().deleteMeet(id: id, callback: {
                    self.fetchMeets()
                })
            }
        }
    }
    
    enum Segue: String {
        case addItem
        case editItem
    }
}
