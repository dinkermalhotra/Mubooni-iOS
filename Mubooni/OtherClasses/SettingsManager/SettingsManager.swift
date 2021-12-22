import UIKit
import ObjectMapper

protocol SettingsManagerProtocol: AnyObject
{
    var userProfile: UserProfile?
    {
        get set
    }
    
    func synchronize()
}

class SettingsManager: NSObject, SettingsManagerProtocol
{
    
    let SETTING_USER_PROFILE = "SETTING_USER_PROFILE"

    private var _defaults: UserDefaults?
    private var defaults: UserDefaults
    {
        if let _defaults = _defaults {
            return _defaults
        }
        else {
            _defaults = UserDefaults.standard
        }

        return _defaults ?? UserDefaults.standard
    }
    
    var userProfile: UserProfile?
    {
        get
        {
            if let recent = defaults.value(forKey: SETTING_USER_PROFILE) as? String {
                if let data = recent.data(using: .utf8) {
                    do {
                        if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            return Mapper<UserProfile>().map(JSON: dictionary) as UserProfile?
                        }
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            return nil
        }
        set
        {
            defaults.set(newValue?.description, forKey: SETTING_USER_PROFILE)
        }
    }
    
    func synchronize()
    {
        defaults.synchronize()
    }
}


