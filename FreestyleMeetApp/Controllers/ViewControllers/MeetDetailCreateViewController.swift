import Foundation
import UIKit
import MapKit

class MeetDetailCreateViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var model = MeetModel(name: "", locationName: "", date: "", time: "", latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initMap()
        initDatePicker()
    }
    
    private func initNavigationBar() {
        navigationController?.visibleViewController?.title = Strings.createNewMeet
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.save, style: .done, target: self, action: #selector(saveButtonAction(_:)))
    }
    
    private func initMap() {
        mapView.delegate = self
        
        let gestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.mapTappedAction(gestureReconizer:)))
        gestureRecogniser.delegate = self
        mapView.addGestureRecognizer(gestureRecogniser)
    }
    
    private func initDatePicker() {
        let now = Date(timeIntervalSinceNow: 0)
        datePicker.minimumDate = now
    }
    
    @objc func saveButtonAction(_ sender: UIButton) {
        guard let name = nameTextField.text, let locationName = locationNameTextField.text,
            !name.isEmpty, !locationName.isEmpty else {
                self.alert(title: Strings.error, message: Strings.notAllFieldsAreProvided)
                return
        }
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        
        model.date = "\(dateComponents.year!)年\(dateComponents.month!)月\(dateComponents.day!)日"
        model.time = "\(dateComponents.hour!):\(dateComponents.minute!)"
        model.locationName = locationName
        model.name = name
        
        FirebaseHandler.getInstance().saveMeet(model: model, callback: {
            navigationController?.popViewController(animated: true)
        })
    }
    
    @objc private func mapTappedAction(gestureReconizer: UILongPressGestureRecognizer) {
        mapView.removeAllPins()
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        mapView.addMapPin(latitude: latitude, longitude: longitude, title: "Aaa")
        model.latitude = latitude
        model.longitude = longitude
    }
}
