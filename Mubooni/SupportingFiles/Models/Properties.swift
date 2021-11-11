import ObjectMapper

class Properties: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        address <- map[WSResponseParams.WS_RESP_PARAM_ADDRESS]
        app_Attachments <- map[WSResponseParams.WS_RESP_PARAM_APP_ATTACHMENTS]
        id <- map[WSResponseParams.WS_RESP_PARAM_ID]
        units <- map[WSResponseParams.WS_RESP_PARAM_UNITS]
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
    lazy var app_Attachments = [AppAttachments]()
    lazy var id = String()
    lazy var units = [Units]()
}

class AppAttachments: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {}
    
    public init(){
        
    }
    
    func mapping(map: Map) {
        img <- map[WSResponseParams.WS_RESP_PARAM_IMG]
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
    
    lazy var img = String()
}
