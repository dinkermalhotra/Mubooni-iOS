import ObjectMapper

class UnitType: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        estateType <- map[WSResponseParams.WS_RESP_PARAM_ESTATE_TYPE]
        id <- map[WSResponseParams.WS_RESP_PARAM_ID]
        unitName <- map[WSResponseParams.WS_RESP_PARAM_UNIT_NAME]
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
    
    lazy var estateType = String()
    lazy var id = String()
    lazy var unitName = String()
}

