import Foundation
import MapKit

extension MKMapView {
    func addMapPin(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subTitle: String? = nil) {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.subtitle = subTitle
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        self.addAnnotation(pin)
    }
}
