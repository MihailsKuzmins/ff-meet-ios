import Foundation
import UIKit
import MapKit

class MeetReadDetailViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    public var id: String?
    private let zoomLevel: Double = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        FirebaseHandler.getInstance().getMeet(id: id!, onSuccessCallback: { data in
            let latitude = data[CoreConstants.DbKeys.meetLatitude] as! CLLocationDegrees
            let longitude = data[CoreConstants.DbKeys.meetLongitude] as! CLLocationDegrees
            let date = data[CoreConstants.DbKeys.meetDate] as! String
            let time = data[CoreConstants.DbKeys.meetTime] as! String
            let locationName = data[CoreConstants.DbKeys.meetLocationName] as! String
            let name = data[CoreConstants.DbKeys.meetName] as! String
            
            let model = MeetModel(name: name, locationName: locationName, date: date, time: time, latitude: latitude, longitude: longitude)
            self.initSelf(model)
        }, onErrorCallback: {
            self.alert(title: Strings.error, message: Strings.accessDenied)
        })
    }
    
    private func initSelf(_ model: MeetModel) {
        initMap(model)
        initLabels(model)
    }
    
    private func initMap(_ model: MeetModel) {
        let startCoordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        let span = MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
        let region = MKCoordinateRegion(center: startCoordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.addMapPin(latitude: model.latitude, longitude: model.longitude, title: model.name, subTitle: model.locationName)
    }
    
    private func initLabels(_ model: MeetModel) {
        dateLabel.text = model.date
        timeLabel.text = model.time
    }
}
