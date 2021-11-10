import Foundation
import Alamofire
import ObjectMapper

class WSManager {
    
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
}
