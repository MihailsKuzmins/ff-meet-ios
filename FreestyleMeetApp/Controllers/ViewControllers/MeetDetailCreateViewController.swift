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
        
        initMap()
        initDatePicker()
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
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        guard var name = nameTextField.text, let locationName = locationNameTextField.text,
            !name.isEmpty, !locationName.isEmpty else {
                self.alert(title: Strings.error, message: Strings.notAllFieldsAreProvided)
                return
        }
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
