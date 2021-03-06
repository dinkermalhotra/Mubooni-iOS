import Foundation
import Alamofire
import ObjectMapper

class WSManager {
    
    static var _settings: SettingsManager?
    
    static var settings: SettingsManagerProtocol?
    {
        if let _ = WSManager._settings {
        }
        else {
            WSManager._settings = SettingsManager()
        }

        return WSManager._settings
    }
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // MARK: GET USER ROLES
    class func wsCallUserRole(completion:@escaping (_ isSuccess: Bool, _ message: String, _ userRoles: [UserRoles]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getUserRoles, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let result = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let userRoles = Mapper<UserRoles>().mapArray(JSONArray: result) as [UserRoles]? {
                                completion(true, "", userRoles)
                            }
                            else {
                                completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: GET SERVICE PROVIDERS SPECILIZATIONS
    class func wsCallSpecilizations(completion:@escaping (_ isSuccess: Bool, _ message: String, _ userRoles: [Specilizations]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getUserSpecialisations, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let result = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let userRoles = Mapper<Specilizations>().mapArray(JSONArray: result) as [Specilizations]? {
                                completion(true, "", userRoles)
                            }
                            else {
                                completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: CHECK GOOGLE ACCOUNT EXIST
    class func wsCallCheckGoogleAccountExist(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ userId: String)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.checkGoogleIdExist, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            completion(true, "")
                        }
                        else {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: AnyObject]] {
                                completion(false, data.count > 0 ? data[0][WSResponseParams.WS_RESP_PARAM_USER_ID] as? String ?? "" : "")
                            }
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "")
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: CHECK FACEBOOK ACCOUNT EXIST
    class func wsCallCheckFacebookAccountExist(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ userId: String)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.checkFacebookIdExist, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            completion(true, "")
                        }
                        else {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: AnyObject]] {
                                completion(false, data.count > 0 ? data[0][WSResponseParams.WS_RESP_PARAM_USER_ID] as? String ?? "" : "")
                            }
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "")
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: LOGIN
    class func wsCallLogin(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ userProfile: UserProfile?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.loginUser, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [String: Any], let profile = Mapper<UserProfile>().map(JSON: data) as UserProfile? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", profile)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: USER SIGN UP
    class func wsCallRegistration(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ userProfile: UserProfile?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.registerUser, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [String: Any], let profile = Mapper<UserProfile>().map(JSON: data) as UserProfile? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", profile)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: FEATURED PROPERTIES FOR GUEST
    class func wsCallFeaturedProperties(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ properties: [Properties]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getFeaturedProperties, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let properties = Mapper<Properties>().mapArray(JSONArray: data) as [Properties]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", properties)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: SERVICE PROVIDERS
    class func wsCallGetServiceProviders(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ serviceProviders: [ServiceProviders]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getServiceProviders, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let serviceProviders = Mapper<ServiceProviders>().mapArray(JSONArray: data) as [ServiceProviders]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", serviceProviders)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: AGENT PROPERTIES
    class func wsCallUserProperties(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ properties: [Properties]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getUserProperties, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let properties = Mapper<Properties>().mapArray(JSONArray: data) as [Properties]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", properties)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: USER PROFILE
    class func wsCallGetUserProfile(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ userProfile: UserProfile?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getUserProfile, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [String: Any], let profile = Mapper<UserProfile>().map(JSON: data) as UserProfile? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", profile)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: PROPERTY TYPE
    class func wsCallGetPropertyTypes(completion:@escaping (_ isSuccess: Bool, _ message: String, _ propertyTypes: [PropertyTypes]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getPropertyTypes, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let propertyTypes = Mapper<PropertyTypes>().mapArray(JSONArray: data) as [PropertyTypes]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", propertyTypes)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: UNIT TYPE
    class func wsCallGetUnitType(completion:@escaping (_ isSuccess: Bool, _ message: String, _ unitType: [UnitType]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getUnitType, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let unitTypes = Mapper<UnitType>().mapArray(JSONArray: data) as [UnitType]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", unitTypes)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: AREA TYPE
    class func wsCallGetAreaType(completion:@escaping (_ isSuccess: Bool, _ message: String, _ areaType: [AreaType]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getAreaType, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let areaTypes = Mapper<AreaType>().mapArray(JSONArray: data) as [AreaType]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", areaTypes)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: SEARCH SERVICE PROVIDERS
    class func wsCallSearchServiceProviders(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ serviceProviders: [ServiceProviders]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.searchServiceProviders, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let serviceProviders = Mapper<ServiceProviders>().mapArray(JSONArray: data) as [ServiceProviders]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", serviceProviders)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: FILTERED PROPERTIES FOR GUEST
    class func wsCallFilteredProperties(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ properties: [Properties]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getFilteredProperties, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let properties = Mapper<Properties>().mapArray(JSONArray: data) as [Properties]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", properties)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: PROPERTIES ON MAP
    class func wsCallGetPropertiesOnMap(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ properties: [Properties]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getPropertiesOnMap, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let properties = Mapper<Properties>().mapArray(JSONArray: data) as [Properties]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", properties)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: GET AGENTS JOBS & REQUESTS
    class func wsCallGetAgentJobs(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ jobs: [Jobs]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getAgentJobs, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let jobs = Mapper<Jobs>().mapArray(JSONArray: data) as [Jobs]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", jobs)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: GET AGENTS PAYMENT REPORTS
    class func wsCallGetAgentPaymentReports(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ paymentReports: [PaymentReports]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getAgentReports, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let paymentReports = Mapper<PaymentReports>().mapArray(JSONArray: data) as [PaymentReports]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", paymentReports)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: GET AGENTS TENANTS
    class func wsCallGetAgentTenants(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ tenants: [Tenants]?)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getAgentTenants, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? [[String: Any]], let tenants = Mapper<Tenants>().mapArray(JSONArray: data) as [Tenants]? {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", tenants)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", nil)
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: GET PROPERTY LIMIT
    class func wsCallGetPropertyLimit(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String, _ limit: String)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.getPropertyLimit, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            if let data = responseValue[WSResponseParams.WS_RESP_PARAM_DATA] as? String {
                                completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", data)
                            }
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "", "")
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "", "")
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, "")
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: SEND INQUIRY
    class func wsCallSendInquiry(_ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String)->()) {
        if WSManager.isConnectedToInternet() {
            AF.request(WebService.sendInquiry, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "")
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "")
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "")
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            })
        }
        else {
            
        }
    }
    
    // MARK: Add Property
    class func wsCallAddProperty(_ requestParams: [String: AnyObject], _ imageData: [Data], completion:@escaping (_ isSuccess: Bool, _ message: String)->()) {
        if WSManager.isConnectedToInternet() {
            let timestamp = NSDate().timeIntervalSince1970
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in requestParams {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) ?? Data(), withName: key)
                }
                
                for (index, data) in imageData.enumerated() {
                    multipartFormData.append(data, withName: WSRequestParams.WS_REQS_PARAM_FILENAME, fileName: "\(timestamp)\(index).jpg", mimeType: "image/jpeg")
                }
                
            }, to: WebService.saveProperty, method: .post, headers: nil, interceptor: nil).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success(let data):
                    if let responseValue = data as? [String: AnyObject] {
                        if responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String == WSResponseParams.WS_RESP_PARAM_TRUE {
                            completion(true, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "")
                        }
                        else {
                            completion(false, responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String ?? "")
                        }
                    }
                    else {
                        completion(false, responseData.error?.localizedDescription ?? "")
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            })
        }
        else {
            
        }
    }
}
