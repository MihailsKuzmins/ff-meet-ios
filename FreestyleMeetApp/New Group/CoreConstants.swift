import Foundation
import UIKit

class CoreConstants {
    class Storyboards {
        public static let appStoryboard = "AppStoryboard"
    }
    
    class ViewControllers {
        public static let meetList = "MeetListViewController"
    }
    
    class CellIdentifiers {
        public static let MeetTableViewCell = "meetTableViewCell"
    }
    
    class DbKeys {
        public static let meets = "meets"
        public static let meetDate = "date"
        public static let meetLatitude = "latitude"
        public static let meetLocationName = "locationName"
        public static let meetLongitude = "longitude"
        public static let meetName = "name"
    }
    
    class Ui {
        public static let meetCellHeight: CGFloat = 100
    }
}
