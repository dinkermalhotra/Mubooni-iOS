import ObjectMapper

class UserProfile: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        about <- map[WSResponseParams.WS_RESP_PARAM_ABOUT]
        address <- map[WSResponseParams.WS_RESP_PARAM_ADDRESS]
        attachedDoc <- map[WSResponseParams.WS_RESP_PARAM_ATTACHED_DOC]
        countryCode <- map[WSResponseParams.WS_RESP_PARAM_COUNTRY_CODE]
        email <- map[WSResponseParams.WS_RESP_PARAM_EMAIL]
        facebookId <- map[WSResponseParams.WS_RESP_PARAM_FACEBOOK_ID]
        googleId <- map[WSResponseParams.WS_RESP_PARAM_GOOGLE_ID]
        idProof <- map[WSResponseParams.WS_RESP_PARAM_ID_PROOF]
        isPhoneVerify <- map[WSResponseParams.WS_RESP_PARAM_IS_PHONE_VERIFY]
        isUserVerify <- map[WSResponseParams.WS_RESP_PARAM_IS_USER_VERIFY]
        isVerify <- map[WSResponseParams.WS_RESP_PARAM_IS_VERIFY]
        kenyaId <- map[WSResponseParams.WS_RESP_PARAM_KENYA_ID]
        mobile <- map[WSResponseParams.WS_RESP_PARAM_MOBILE]
        name <- map[WSResponseParams.WS_RESP_PARAM_NAME]
        profile <- map[WSResponseParams.WS_RESP_PARAM_PROFILE]
        roleId <- map[WSResponseParams.WS_RESP_PARAM_ROLE_ID]
        subRole <- map[WSResponseParams.WS_RESP_PARAM_SUB_ROLE]
        userId <- map[WSResponseParams.WS_RESP_PARAM_USER_ID]
    }
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
    
    let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        // transform value from String? to Int?
        return Int(value!)
    }, toJSON: { (value: Int?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return String(value)
        }
        return nil
    })
    
    lazy var about = String()
    lazy var address = String()
    lazy var attachedDoc = String()
    lazy var countryCode = String()
    lazy var email = String()
    lazy var facebookId = String()
    lazy var googleId = String()
    lazy var idProof = String()
    lazy var isPhoneVerify = String()
    lazy var isUserVerify = String()
    lazy var isVerify = String()
    lazy var kenyaId = String()
    lazy var mobile = String()
    lazy var name = String()
    lazy var profile = String()
    lazy var roleId = String()
    lazy var subRole = String()
    lazy var userId = String()
}

