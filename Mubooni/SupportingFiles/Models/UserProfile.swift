import ObjectMapper

class UserProfile: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        email <- map[WSResponseParams.WS_RESP_PARAM_EMAIL]
        name <- map[WSResponseParams.WS_RESP_PARAM_NAME]
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
    
    lazy var email = String()
    lazy var name = String()
    lazy var userId = String()
}

