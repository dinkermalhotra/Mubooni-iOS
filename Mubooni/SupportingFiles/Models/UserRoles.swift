import ObjectMapper

class UserRoles: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        role <- map[WSResponseParams.WS_RESP_PARAM_ROLE]
        roleId <- map[WSResponseParams.WS_RESP_PARAM_ROLE_ID]
        roleDes <- map[WSResponseParams.WS_RESP_PARAM_ROLE_DES]
        roleImage <- map[WSResponseParams.WS_RESP_PARAM_ROLE_IMAGE]
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
    
    lazy var role = String()
    lazy var roleId = String()
    lazy var roleDes = String()
    lazy var roleImage = String()
}
