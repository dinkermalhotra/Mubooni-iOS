import Foundation
import Alamofire

class WSManager {
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // MARK: GET API
    class func wsCallLogin(_ url: String, _ requestParams: [String: AnyObject], completion:@escaping (_ isSuccess: Bool, _ message: String)->()) {
        AF.request(url, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {(responseData) -> Void in
            print(responseData.result)
//            if let responseValue = responseData.result as? [String: AnyObject] {
//                print(responseValue)
//                if (responseValue[WSResponseParams.WS_RESP_PARAM_STATUS] as? String != WSResponseParams.WS_RESP_PARAM_ERROR) {
//                    completion(true, "")
//                } else {
//                    if let responseMessage = responseValue[WSResponseParams.WS_RESP_PARAM_MESSAGE] as? String {
//                        completion(false, responseMessage)
//                    }
//                }
//            } else {
//                completion(false, "No parameters found")
//            }
        })
    }
}
