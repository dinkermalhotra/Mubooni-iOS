import ObjectMapper

class Units: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        id <- map[WSResponseParams.WS_RESP_PARAM_ID]
        monthlyRent <- map[WSResponseParams.WS_RESP_PARAM_MONTHLY_RENT]
        unitStatus <- map[WSResponseParams.WS_RESP_PARAM_UNIT_STATUS]
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
    
    lazy var id = String()
    lazy var monthlyRent = String()
    lazy var unitStatus = String()
}
