import ObjectMapper

class AreaType: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        areaId <- map[WSResponseParams.WS_RESP_PARAM_AREA_ID]
        areaSizeName <- map[WSResponseParams.WS_RESP_PARAM_AREA_SIZE_NAME]
        estateSizeType <- map[WSResponseParams.WS_RESP_PARAM_ESTATE_SIZE_TYPE]
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
    
    lazy var areaId = String()
    lazy var areaSizeName = String()
    lazy var estateSizeType = String()
}

