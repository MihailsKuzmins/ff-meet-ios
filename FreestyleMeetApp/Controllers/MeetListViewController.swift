import Foundation
import UIKit

class MeetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    public var meets: Array<MeetListModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
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
}
