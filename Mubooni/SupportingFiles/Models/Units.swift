import ObjectMapper

class Units: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        area <- map[WSResponseParams.WS_RESP_PARAM_AREA]
        areaType <- map[WSResponseParams.WS_RESP_PARAM_AREA_TYPE]
        checkShortStay <- map[WSResponseParams.WS_RESP_PARAM_CHECK_SHORT_STAY]
        id <- map[WSResponseParams.WS_RESP_PARAM_ID]
        monthlyRent <- map[WSResponseParams.WS_RESP_PARAM_MONTHLY_RENT]
        perDay <- map[WSResponseParams.WS_RESP_PARAM_PER_DAY]
        stayDays <- map[WSResponseParams.WS_RESP_PARAM_STAY_DAYS]
        unitNumber <- map[WSResponseParams.WS_RESP_PARAM_UNIT_NUMBER]
        unitStatus <- map[WSResponseParams.WS_RESP_PARAM_UNIT_STATUS]
        unitType <- map[WSResponseParams.WS_RESP_PARAM_UNIT_TYPE]
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
    
    lazy var area = String()
    lazy var areaType = String()
    lazy var checkShortStay = String()
    lazy var id = String()
    lazy var monthlyRent = String()
    lazy var perDay = String()
    lazy var stayDays = String()
    lazy var unitNumber = String()
    lazy var unitStatus = String()
    lazy var unitType = String()
}
