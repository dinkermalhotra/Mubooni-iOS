import ObjectMapper

class Tenants: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        email <- map[WSResponseParams.WS_RESP_PARAM_EMAIL]
        propertyAddress <- map[WSResponseParams.WS_RESP_PARAM_PROPERTY_ADDRESS]
        tenantName <- map[WSResponseParams.WS_RESP_PARAM_TENANT_NAME]
        unitNumber <- map[WSResponseParams.WS_RESP_PARAM_UNIT_NUMBER]
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
    lazy var propertyAddress = String()
    lazy var tenantName = String()
    lazy var unitNumber = String()
}

