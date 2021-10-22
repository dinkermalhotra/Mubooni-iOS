import UIKit

class Singleton: NSObject
{
    static var specilizations: [Specilizations]?
    static var userRoles: [UserRoles]?
}

class UserData: NSObject
{
    static var email: String?
    static var facebookId: String?
    static var googleId: String?
    static var name: String?
}
