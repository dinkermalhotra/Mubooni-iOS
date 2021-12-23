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
    static let iPhone12     = isiPhone && UIScreen.main.bounds.size.height == 844.0
    static let iPhoneMAX    = isiPhone && UIScreen.main.bounds.size.height == 896.0
    
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
    static let backgroundGreenColor = UIColor.init(hex: "148E45")
    static let blackTransparentColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
    static let darkGreenColor = UIColor.init(hex: "096B30")
    static let greenColor = UIColor.init(hex: "00BF4B")
    static let placeholderColor = UIColor.init(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3)
    static let redColor = UIColor.init(hex: "ED1F23")
}

struct MubooniFonts {
    static let FONT_ROBOTO_BOLD_16 = UIFont.init(name: "Roboto-Bold", size: 16)
    static let FONT_ROBOTO_REGULAR_10 = UIFont.init(name: "Roboto-Regular", size: 10)
    static let FONT_ROBOTO_REGULAR_14 = UIFont.init(name: "Roboto-Regular", size: 14)
    static let FONT_ROBOTO_REGULAR_16 = UIFont.init(name: "Roboto-Regular", size: 16)
}

struct CellIds {
    static let AddPropertyImageCell     = "AddPropertyImageCell"
    static let AddPropertyUnitCell      = "AddPropertyUnitCell"
    static let BedroomSelectionCell     = "BedroomSelectionCell"
    static let CheckboxCell             = "CheckboxCell"
    static let FindServiceProviderCell  = "FindServiceProviderCell"
    static let ImagesCell               = "ImagesCell"
    static let IntroScreensCell         = "IntroScreensCell"
    static let JobListCell              = "JobListCell"
    static let MainFeaturedCell         = "MainFeaturedCell"
    static let MyPropertiesCell         = "MyPropertiesCell"
    static let ServiceProviderCell      = "ServiceProviderCell"
    static let ServiceReportCell        = "ServiceReportCell"
    static let SettingsCell             = "SettingsCell"
    static let TenantListCell           = "TenantListCell"
}

struct GoogleApiKey {
    static let API_KEY  = "AIzaSyBWxm8xp__JpBkj51Ubicij_lQs5p_pmA4"
}

struct Strings {
    static let ADDRESS = "Address"
    static let ALL = "all"
    static let BACK_YARD = "Back yard"
    static let BASKETBALL_COURT = "Basketball court"
    static let BATH = "Bath"
    static let BATHS = "Baths"
    static let BEDROOM = "Bedroom"
    static let BEDROOMS = "Bedrooms"
    static let BOOKING_INFO = "BOOKING DETAILS"
    static let BOOK_YOUR_SLOT = "BOOK YOUR SLOT"
    static let BUILDING_NAME = "Building name"
    static let BUY = "Buy"
    static let CENTRAL_AIR = "Central air"
    static let CHAIR_ACCESSIBLE = "Chair accessible"
    static let CHOOSE_PHOTO = "Choose Photo"
    static let CONTENT_SIZE = "contentSize"
    static let DASHBOARD = "dashboard"
    static let ELECTRICITY = "Electricity"
    static let ELEVATOR = "Elevator"
    static let EQUIPPED_KITCHEN = "Equipped kitchen"
    static let FIRE_PLACE = "Fire place"
    static let FOR_RENT = "For rent"
    static let FOR_SALE = "For sale"
    static let FOR_SHORT_STAYS = "For short stays"
    static let FREEHOLD = "Freehold"
    static let FRONT_YARD = "Front yard"
    static let GARAGE_ATTACHED = "Garage attached"
    static let GARBAGE = "Garbage"
    static let GYM = "Gym"
    static let HEATING = "Heating"
    static let HOT_BATH = "Hot bath"
    static let INTERNET = "Internet"
    static let JOBS = "jobs"
    static let KES = "KES"
    static let LAND = "LAND"
    static let LAUNDRY = "Laundry"
    static let LEASE = "Lease"
    static let LEASEHOLD = "Leasehold"
    static let LOCAL = "local"
    static let MEDIA_ROOM = "Media room"
    static let MONTHLY_RENT = "Monthly Rent"
    static let NATURAL_GAS = "Natural gas"
    static let NO = "No"
    static let OK = "Ok"
    static let ONE = "1"
    static let OTHER_FEATURES = "Other features (separate with ',')"
    static let OWNER_NOTES = "Owner/Agent Notes"
    static let PLOT_NUMBER = "Plot number"
    static let POOL = "Pool"
    static let RENT = "Rent"
    static let REQUESTS = "requests"
    static let SELLING_PRICE = "Selling Price"
    static let SERVICE_CHARGE = "Service charge"
    static let SERVICE_PROVIDER = "SERVICE PROVIDER"
    static let SHORT_STAY = "Short Stay"
    static let SMOKE_DETECTORS = "Smoke detectors"
    static let TAKE_PHOTO = "Take Photo"
    static let TENANT = "TENANT"
    static let UNIT_STATUS_SALE = "SALE"
    static let UNVERIFIED = "Unverified"
    static let VENTILATION = "Ventilation"
    static let VERIFIED = "Verified"
    static let WATER = "Water"
    static let WATER_AND_DRYER = "Water and dryer"
    static let WIFI = "Wifi"
    static let YES = "Yes"
    static let ZERO = "0"
}

struct Alert {
    static let ALERT = "Alert"
    static let CHOOSE = "Choose"
    static let ERROR = "Error"
    static let LOGOUT = "Logout"
    static let THANK_YOU = "Thank You"
    static let SORRY = "SORRY!"
    static let SUCCESS = "SUCCESS"
}
