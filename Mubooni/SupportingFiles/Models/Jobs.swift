import ObjectMapper

class Jobs: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        address <- map[WSResponseParams.WS_RESP_PARAM_ADDRESS]
        agentId <- map[WSResponseParams.WS_RESP_PARAM_AGENT_ID]
        estateId <- map[WSResponseParams.WS_RESP_PARAM_ESTATE_ID]
        estateName <- map[WSResponseParams.WS_RESP_PARAM_ESTATE_NAME]
        featuredStatus <- map[WSResponseParams.WS_RESP_PARAM_FEATURED_STATUS]
        id <- map[WSResponseParams.WS_RESP_PARAM_ID]
        invoiceStatus <- map[WSResponseParams.WS_RESP_PARAM_INVOICE_STATUS]
        jobAbility <- map[WSResponseParams.WS_RESP_PARAM_JOB_ABILITY]
        jobStatus <- map[WSResponseParams.WS_RESP_PARAM_JOB_STATUS]
        latitude <- map[WSResponseParams.WS_RESP_PARAM_LAT]
        longitude <- map[WSResponseParams.WS_RESP_PARAM_LNG]
        ownerName <- map[WSResponseParams.WS_RESP_PARAM_OWNER_NAME]
        ownerNotes <- map[WSResponseParams.WS_RESP_PARAM_OWNER_NOTES]
        payStatus <- map[WSResponseParams.WS_RESP_PARAM_PAY_STATUS]
        problemDescription <- map[WSResponseParams.WS_RESP_PARAM_PROBLEM_DESCRIPTION]
        requestDate <- map[WSResponseParams.WS_RESP_PARAM_REQUEST_DATE]
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
    lazy var agentId = String()
    lazy var estateId = String()
    lazy var estateName = String()
    lazy var featuredStatus = String()
    lazy var id = String()
    lazy var invoiceStatus = String()
    lazy var jobAbility = String()
    lazy var jobStatus = String()
    lazy var latitude = String()
    lazy var longitude = String()
    lazy var ownerName = String()
    lazy var ownerNotes = String()
    lazy var payStatus = String()
    lazy var problemDescription = String()
    lazy var requestDate = String()
}
