import ObjectMapper

class ServiceProviders: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        address <- map[WSResponseParams.WS_RESP_PARAM_ADDRESS]
        name <- map[WSResponseParams.WS_RESP_PARAM_NAME]
        profile <- map[WSResponseParams.WS_RESP_PARAM_PROFILE]
        specialisations <- map[WSResponseParams.WS_RESP_PARAM_SPECIALISATIONS]
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
    
    lazy var address = String()
    lazy var name = String()
    lazy var profile = String()
    lazy var specialisations = String()
}
