import Foundation
import UIKit
import SKActivityIndicatorView

class Helper: NSObject {
    
    //MARK:- set and get preferences for NSString
    /*!
     method getPreferenceValueForKey
     abstract To get the preference value for the key that has been passed
     */
    // NSUserDefaults methods which have been used in entire app.
    
    class func getPREF(_ key: String) -> String? {
        return Foundation.UserDefaults.standard.value(forKey: key) as? String
    }
    
    class func getUserPREF(_ key: String) -> Data? {
        return Foundation.UserDefaults.standard.value(forKey: key as String) as? Data
    }
    /*!
     method setPreferenceValueForKey for int value
     abstract To set the preference value for the key that has been passed
     */
    class func setPREF(_ sValue: String, key: String) {
        Foundation.UserDefaults.standard.setValue(sValue, forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    /*!
     method delPREF for string
     abstract To delete the preference value for the key that has been passed
     */
    class func  delPREF(_ key: String) {
        Foundation.UserDefaults.standard.removeObject(forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    //MARK:- set and get preferences for Integer
    /*!
     method getPreferenceValueForKey for array for int value
     abstract To get the preference value for the key that has been passed
     */
    class func getIntPREF(_ key: String) -> Int? {
        return Foundation.UserDefaults.standard.object(forKey: key as String) as? Int
    }
    /*!
     method setPreferenceValueForKey
     abstract To set the preference value for the key that has been passed
     */
    class func setIntPREF(_ sValue: Int, key: String) {
        Foundation.UserDefaults.standard.setValue(sValue, forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    /*!
     method delPREF for integer
     abstract To delete the preference value for the key that has been passed
     */
    class func  delIntPREF(_ key: String) {
        Foundation.UserDefaults.standard.removeObject(forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    //MARK:- set and get preferences for Double
    /*!
     method getPreferenceValueForKey for array for int value
     abstract To get the preference value for the key that has been passed
     */
    class func getDoublePREF(_ key: String) -> Double? {
        return Foundation.UserDefaults.standard.object(forKey: key as String) as? Double
    }
    /*!
     method setPreferenceValueForKey
     abstract To set the preference value for the key that has been passed
     */
    class func setDoublePREF(_ sValue: Double, key: String) {
        Foundation.UserDefaults.standard.setValue(sValue, forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    //MARK:- set and get preferences for Array
    /*!
     method getPreferenceValueForKey for array
     abstract To get the preference value for the key that has been passed
     */
    class func getArrPREF(_ key: String) -> [Int]? {
        return Foundation.UserDefaults.standard.object(forKey: key as String) as? [Int]
    }
    /*!
     method setPreferenceValueForKey for array
     abstract To set the preference value for the key that has been passed
     */
    class func setArrPREF(_ sValue: [Int], key: String) {
        Foundation.UserDefaults.standard.set(sValue, forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    /*!
     method delPREF
     abstract To delete the preference value for the key that has been passed
     */
    class func  delArrPREF(_ key: String) {
        Foundation.UserDefaults.standard.removeObject(forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    //MARK:- set and get preferences for Boolean
    /*!
     method getPreferenceValueForKey for boolean
     abstract To get the preference value for the key that has been passed
     */
    class func  delDicPREF(_ key: String) {
        Foundation.UserDefaults.standard.removeObject(forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    
    class func getBoolPREF(_ key: String) -> Bool {
        return Foundation.UserDefaults.standard.bool(forKey: key as String)
    }
    /*!
     method setBoolPreferenceValueForKey
     abstract To set the preference value for the key that has been passed
     */
    class func setBoolPREF(_ sValue: Bool , key: String){
        Foundation.UserDefaults.standard.set(sValue, forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    /*!
     method delPREF for boolean
     abstract To delete the preference value for the key that has been passed
     */
    class func  delBoolPREF(_ key: String) {
        Foundation.UserDefaults.standard.removeObject(forKey: key as String)
        Foundation.UserDefaults.standard.synchronize()
    }
    
    class func showLoader(onVC viewController: UIViewController) {
        SKActivityIndicator.spinnerColor(MubooniColors.darkGreenColor)
        
        SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
        SKActivityIndicator.show("", userInteractionStatus: false)
    }
    
    class func hideLoader(onVC viewController: UIViewController) {
        SKActivityIndicator.dismiss()
    }
    
    class func showOKAlert(onVC viewController: UIViewController, title: String, message: String) {
        DispatchQueue.main.async {
            let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style:.default, handler: nil))
            
            alert.view.tintColor = UIColor.black
            alert.view.setNeedsLayout()
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
    class func showOKAlertWithCompletion(onVC viewController: UIViewController, title: String, message: String, btnOkTitle: String, onOk: @escaping ()->()) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnOkTitle, style:.default, handler: { (action:UIAlertAction) in
                onOk()
            }))
            alert.view.tintColor = UIColor.black
            alert.view.setNeedsLayout()
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showOKCancelAlertWithCompletion(onVC viewController: UIViewController, title: String, message: String, btnOkTitle: String, btnCancelTitle: String, onOk: @escaping ()->()) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnOkTitle, style:.default, handler: { (action:UIAlertAction) in
                onOk()
            }))
            alert.addAction(UIAlertAction(title: btnCancelTitle, style:.destructive, handler: { (action:UIAlertAction) in
                
            }))
            alert.view.tintColor = MubooniColors.darkGreenColor
            alert.view.setNeedsLayout()
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showClientAlertWithCompletion(onVC viewController: UIViewController, title: String, message: String, btnOkTitle: String, btnCancelTitle: String, onOk: @escaping ()->(), onCancel: @escaping ()->()) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnOkTitle, style:.default, handler: { (action:UIAlertAction) in
                onOk()
            }))
            alert.addAction(UIAlertAction(title: btnCancelTitle, style:.default, handler: { (action:UIAlertAction) in
                onCancel()
            }))
            alert.view.tintColor = UIColor.black
            alert.view.setNeedsLayout()
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showThreeButtonsAlertWithCompletion(onVC viewController: UIViewController, title: String?, message: String?, btnOneTitle: String, btnTwoTitle: String, btnThreeTitle: String, onBtnOneClick: @escaping ()->(), onBtnTwoClick: @escaping ()->()) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnOneTitle, style:.default, handler: { (action:UIAlertAction) in
                onBtnOneClick()
            }))
            alert.addAction(UIAlertAction(title: btnTwoTitle, style:.default, handler: { (action:UIAlertAction) in
                onBtnTwoClick()
            }))
            alert.addAction(UIAlertAction(title: btnThreeTitle, style:.default, handler: { (action:UIAlertAction) in
                
            }))
            alert.view.tintColor = UIColor.black
            alert.view.setNeedsLayout()
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showSingleActionAlert(onVC viewController: UIViewController, title: String?, titleOne: String, actionOne:@escaping ()->(), actionCancel:@escaping ()->()) {
        DispatchQueue.main.async {
            let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                actionCancel()
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)
            
            let saveActionButton: UIAlertAction = UIAlertAction(title: titleOne, style: .default) { action -> Void in
                actionOne()
            }
            actionSheetControllerIOS8.addAction(saveActionButton)
            
            if let popoverPresentationController = actionSheetControllerIOS8.popoverPresentationController {
                popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                
                var rect = viewController.view.frame;
                
                rect.origin.x = viewController.view.frame.size.width / 20;
                rect.origin.y = viewController.view.frame.size.height / 20;
                
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = rect
            }
            
            actionSheetControllerIOS8.view.tintColor = UIColor.black
            viewController.present(actionSheetControllerIOS8, animated: true, completion: nil)
        }
    }
    
    class func showThreeOptionActionAlert(onVC viewController: UIViewController, title: String?, titleOne: String, actionOne:@escaping ()->(), titleTwo: String, actionTwo:@escaping ()->(), titleThree: String, actionThree:@escaping ()->()) {
        DispatchQueue.main.async {
            let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)
            
            let oneActionButton: UIAlertAction = UIAlertAction(title: titleOne, style: .destructive) { action -> Void in
                actionOne()
            }
            actionSheetControllerIOS8.addAction(oneActionButton)
            
            let twoActionButton: UIAlertAction = UIAlertAction(title: titleTwo, style: .default) { action -> Void in
                actionTwo()
            }
            actionSheetControllerIOS8.addAction(twoActionButton)
            
            let threeActionButton: UIAlertAction = UIAlertAction(title: titleThree, style: .default) { action -> Void in
                actionThree()
            }
            actionSheetControllerIOS8.addAction(threeActionButton)
            
            if let popoverPresentationController = actionSheetControllerIOS8.popoverPresentationController {
                popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                
                var rect = viewController.view.frame;
                
                rect.origin.x = viewController.view.frame.size.width / 20;
                rect.origin.y = viewController.view.frame.size.height / 20;
                
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = rect
            }
            
            actionSheetControllerIOS8.view.tintColor = UIColor.black
            viewController.present(actionSheetControllerIOS8, animated: true, completion: nil)
        }
    }
    
    class func showFiveOptionsActionAlert(onVC viewController: UIViewController, title: String, titleOne: String, actionOne:@escaping ()->(), titleTwo: String, actionTwo:@escaping ()->(), titleThree: String, actionThree:@escaping ()->(), titleFour: String, actionFour:@escaping ()->(), titleFive: String, actionFive:@escaping ()->()) {
        DispatchQueue.main.async {
            let actionSheetController: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                
            }
            actionSheetController.addAction(cancelActionButton)
            
            let actionButtonOne: UIAlertAction = UIAlertAction(title: titleOne, style: .default) { action -> Void in
                actionOne()
            }
            actionSheetController.addAction(actionButtonOne)
            
            let actionButtonTwo: UIAlertAction = UIAlertAction(title: titleTwo, style: .default) { action -> Void in
                actionTwo()
            }
            actionSheetController.addAction(actionButtonTwo)
            
            let actionButtonThree: UIAlertAction = UIAlertAction(title: titleThree, style: .default) { action -> Void in
                actionThree()
            }
            actionSheetController.addAction(actionButtonThree)
            
            let actionButtonFour: UIAlertAction = UIAlertAction(title: titleFour, style: .default) { action -> Void in
                actionFour()
            }
            actionSheetController.addAction(actionButtonFour)
            
            let actionButtonFive: UIAlertAction = UIAlertAction(title: titleFive, style: .destructive) { action -> Void in
                actionFive()
            }
            actionSheetController.addAction(actionButtonFive)
            
            if let popoverPresentationController = actionSheetController.popoverPresentationController {
                popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                
                var rect = viewController.view.frame;
                
                rect.origin.x = viewController.view.frame.size.width / 20;
                rect.origin.y = viewController.view.frame.size.height / 20;
                
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = rect
            }
            
            actionSheetController.view.tintColor = UIColor.black
            viewController.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
    class func convertBase64Image(_ imageData: Data?) -> String {
        var ret = ""
        if let imageData = imageData {
            ret =  "data:image/png;base64,\(imageData.base64EncodedString(options: .lineLength64Characters))"
        }
        
        return ret
    }
    
    class func convertBase64ImageRemove(_ imageData: Data?) -> String {
        var ret = "delete"
        if let imageData = imageData {
            ret =  "data:image/png;base64,\(imageData.base64EncodedString(options: .lineLength64Characters))"
        }
        
        return ret
    }
    
    class func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    class func getYesterdayDate() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: yesterday ?? Date())
    }
    
    class func todayDate() -> String {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.month, .day], from: Date())
        let day = dateComponent.day ?? 0
        let month = dateComponent.month ?? 0
        
        var dayValue = ""
        if String(day).count == 1 {
            dayValue = "0\(day)"
        }
        else {
            dayValue = "\(day)"
        }
        
        var monthValue = ""
        if String(month).count == 1 {
            monthValue = "0\(month)"
        }
        else {
            monthValue = "\(month)"
        }
        
        return "\(monthValue)-\(dayValue)"
    }
    
    class func tomorrowDate() -> String {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.month, .day], from: Date())
        let day = (dateComponent.day ?? 0) + 1
        let month = dateComponent.month ?? 0
        
        var dayValue = ""
        if String(day).count == 1 {
            dayValue = "0\(day)"
        }
        else {
            dayValue = "\(day)"
        }
        
        var monthValue = ""
        if String(month).count == 1 {
            monthValue = "0\(month)"
        }
        else {
            monthValue = "\(month)"
        }
        
        return "\(monthValue)-\(dayValue)"
    }
    
    class func laterThisMonth() -> [String] {
        let calendar = Calendar.init(identifier: .gregorian)
        guard let interval = calendar.dateInterval(of: .month, for: Date()) else { return []}
        let dateComponent = calendar.dateComponents([.day, .month], from: interval.end)
        let day = dateComponent.day ?? 0
        let month = dateComponent.month ?? 0
        
        var monthValue = ""
        if String(month).count == 1 {
            monthValue = "0\(month)"
        }
        else {
            monthValue = "\(month)"
        }
        
        var date = [String]()
        for i in 1...day {
            var dayValue = ""
            if String(i).count == 1 {
                dayValue = "0\(i)"
            }
            else {
                dayValue = "\(i)"
            }
            date.append("\(monthValue)-\(dayValue)")
        }
        
        return date
    }
    
    class func convertDateOfBirth(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func shortDateYear(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func shortDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func dateMonth(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd-MMM"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func convertedDateMonth(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func dateMonthYear(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func convertedDateMonthYear(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func birthdayCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
    
    class func birthdayCurrentDateWithoutYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: Date())
    }
    
    class func getCurrentYear() -> String {
        let calendar = Calendar.init(identifier: .gregorian)
        let date = calendar.date(byAdding: .year, value: -21, to: Date())
        let dateComponent = calendar.dateComponents([.year], from: date ?? Date())
        let year = dateComponent.year ?? 0
        
        return String(year)
    }
    
    class func convertCurrentBirthDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func calcAge(_ birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        
        let calendar: Calendar = Calendar.init(identifier: .gregorian)
        let calcAge = calendar.dateComponents([.year], from: birthdayDate ?? Date(), to: Date())
        let age = calcAge.year
        return age ?? 0
    }
    
    class func convertedDateForZodiacSign(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func getZodiacSign(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)

        switch (d,m) {
        case (2...31,1),(1...18,2):
            return "Aquarius"
        case (19...29,2),(1...20,3):
            return "Pisces"
        case (21...31,3),(1...19,4):
            return "Aries"
        case (20...30,4),(1...20,5):
            return "Taurus"
        case (21...31,5),(1...20,6):
            return "Gemini"
        case (21...30,6),(1...22,7):
            return "Cancer"
        case (23...31,7),(1...22,8):
            return "Leo"
        case (23...31,8),(1...22,9):
            return "Virgo"
        case (23...30,9),(1...22,10):
            return "Libra"
        case (23...31,10),(1...21,11):
            return "Scorpio"
        case (22...30,11),(1...21,12):
            return "Sagittarius"
        default:
            return "Capricorn"
        }
    }
    
    class func getZodiacSignImages(_ dateString: String) -> UIImage {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)

        switch (d,m) {
        case (2...31,1),(1...18,2):
            return #imageLiteral(resourceName: "ic_aquarius")
        case (19...29,2),(1...20,3):
            return #imageLiteral(resourceName: "ic_pices")
        case (21...31,3),(1...19,4):
            return #imageLiteral(resourceName: "ic_aries")
        case (20...30,4),(1...20,5):
            return #imageLiteral(resourceName: "ic_taurus")
        case (21...31,5),(1...20,6):
            return #imageLiteral(resourceName: "ic_gemini")
        case (21...30,6),(1...22,7):
            return #imageLiteral(resourceName: "ic_cancer")
        case (23...31,7),(1...22,8):
            return #imageLiteral(resourceName: "ic_leo")
        case (23...31,8),(1...22,9):
            return #imageLiteral(resourceName: "ic_virgo")
        case (23...30,9),(1...22,10):
            return #imageLiteral(resourceName: "ic_libra")
        case (23...31,10),(1...21,11):
            return #imageLiteral(resourceName: "ic_scorpio")
        case (22...30,11),(1...21,12):
            return #imageLiteral(resourceName: "ic_sagittarius")
        default:
            return #imageLiteral(resourceName: "ic_capricorn")
        }
    }
    
    class func previousMonthDate(_ value: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = value
        
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        return pastDate ?? Date()
    }
    
    class func previousYearDate() -> Date {
        let monthsToSubtract = -1
        let daysToSubtract = 0
        let yearsToSubtract = -1
        var dateComponent = DateComponents()
        
        dateComponent.month = monthsToSubtract
        dateComponent.day = daysToSubtract
        dateComponent.year = yearsToSubtract
        
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        return pastDate ?? Date()
    }
    
    class func nextMonthDate(_ value: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = value
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        return futureDate ?? Date()
    }
    
    class func nextYearDate() -> Date {
        let monthsToAdd = 1
        let daysToAdd = 0
        let yearsToAdd = 1
        var dateComponent = DateComponents()
        
        dateComponent.month = monthsToAdd
        dateComponent.day = daysToAdd
        dateComponent.year = yearsToAdd
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        return futureDate ?? Date()
    }
    
    class func calendarHeaderDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd"
        return dateFormatter.string(from: date)
    }
    
    class func notificationHeaderDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "EEEE, MMM dd"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func userBirthdate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func userBirthday(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func updateTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    class func convertTimeToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.date(from: dateString)
        
        return date ?? Date()
    }
    
    class func notificationTime(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func timeZoneDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date ?? Date())
    }
    
    class func birthdayImage(_ firstName: String) -> UIImage {
        if firstName.lowercased().starts(with: "a") || firstName.lowercased().starts(with: "f") || firstName.lowercased().starts(with: "k") || firstName.lowercased().starts(with: "p") || firstName.lowercased().starts(with: "u") {
            return #imageLiteral(resourceName: "ic_avatar")
        }
        else if firstName.lowercased().starts(with: "b") || firstName.lowercased().starts(with: "g") || firstName.lowercased().starts(with: "l") || firstName.lowercased().starts(with: "q") || firstName.lowercased().starts(with: "v") {
            return #imageLiteral(resourceName: "ic_avtar2")
        }
        else if firstName.lowercased().starts(with: "c") || firstName.lowercased().starts(with: "h") || firstName.lowercased().starts(with: "m") || firstName.lowercased().starts(with: "r") || firstName.lowercased().starts(with: "w") {
            return #imageLiteral(resourceName: "ic_avtar4")
        }
        else if firstName.lowercased().starts(with: "d") || firstName.lowercased().starts(with: "i") || firstName.lowercased().starts(with: "n") || firstName.lowercased().starts(with: "s") || firstName.lowercased().starts(with: "x") {
            return #imageLiteral(resourceName: "ic_avtar3")
        }
        else if firstName.lowercased().starts(with: "e") || firstName.lowercased().starts(with: "j") || firstName.lowercased().starts(with: "o") || firstName.lowercased().starts(with: "t") || firstName.lowercased().starts(with: "y") {
            return #imageLiteral(resourceName: "ic_avtar1")
        }
        else {
            return #imageLiteral(resourceName: "ic_pick")
        }
    }
}


