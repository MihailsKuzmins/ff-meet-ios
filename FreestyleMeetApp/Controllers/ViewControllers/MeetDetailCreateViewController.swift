import Foundation
import UIKit
import MapKit

class MeetDetailCreateViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    private var model = MeetModel(name: "", locationName: "", date: "", time: "", latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        initMap()
    }
    
    private func initMap() {
        let gestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.mapTappedAction(gestureReconizer:)))
        gestureRecogniser.delegate = self
        mapView.addGestureRecognizer(gestureRecogniser)
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
