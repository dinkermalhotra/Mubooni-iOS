import UIKit
import Foundation

// App constants
struct CurrentDevice {
    static let isiPhone     = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    static let iPhone4S     = isiPhone && UIScreen.main.bounds.size.height == 480
    static let isiPhone5    = isiPhone && UIScreen.main.bounds.size.height == 568.0
    static let iPhone6      = isiPhone && UIScreen.main.bounds.size.height == 667.0
    static let iPhone6P     = isiPhone && UIScreen.main.bounds.size.height == 736.0
    static let iPhoneX      = isiPhone && UIScreen.main.bounds.size.height == 812.0
    static let iPhoneXS_MAX = isiPhone && UIScreen.main.bounds.size.height == 896.0
    
    static let isiPad       = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    static let iPadMini     = isiPad && UIScreen.main.bounds.size.height <= 1024
}

struct AppConstants {
    @available(iOS 13.0, *)
    static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
    static let PORTRAIT_SCREEN_WIDTH  = UIScreen.main.bounds.size.width
    static let PORTRAIT_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let CURRENT_IOS_VERSION = UIDevice.current.systemVersion
}

struct MubooniColors {
    static let blackTransparentColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
    static let darkGreenColor = UIColor.init(hex: "096B30")
}

struct MubooniFonts {
    static let FONT_ROBOTO_REGULAR_14 = UIFont.init(name: "Roboto-Regular", size: 14)
}

struct CellIds {
    static let IntroScreensCell = "IntroScreensCell"
    static let MainFeaturedCell = "MainFeaturedCell"
}

struct Strings {
    static let BOOKING_INFO = "BOOKING DETAILS"
    static let BOOK_YOUR_SLOT = "BOOK YOUR SLOT"
    static let KES = "KES"
    static let MONTHLY_RENT = "Monthly Rent"
    static let SELLING_PRICE = "Selling Price"
    static let UNIT_STATUS_SALE = "SALE"
}

struct Alert {
    static let ALERT = "Alert"
    static let CHOOSE = "Choose"
    static let ERROR = "Error"
    static let THANK_YOU = "Thank You"
    static let SORRY = "SORRY!"
    static let SUCCESS = "SUCCESS"
}
