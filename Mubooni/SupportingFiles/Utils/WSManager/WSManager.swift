import Foundation
import Alamofire
import ObjectMapper

class WSManager {
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // MARK: GET USER ROLES
    class func wsCallUserRole(completion:@escaping (_ isSuccess: Bool, _ message: String, _ userRoles: [UserRoles]?)->()) {
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
    
    // MARK: GET SERVICE PROVIDERS SPECILIZATIONS
    class func wsCallSpecilizations(completion:@escaping (_ isSuccess: Bool, _ message: String, _ userRoles: [Specilizations]?)->()) {
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
}
