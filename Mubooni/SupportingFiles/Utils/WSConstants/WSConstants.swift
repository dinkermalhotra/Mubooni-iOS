struct WebService {
    static let baseUrl                               = "https://ddfintech.in/mubooni/JSON"
    static let getUserRoles                          = "\(baseUrl)/get_user_roles/app"
    static let getUserSpecialisations                = "\(baseUrl)/get_user_specialisations/app"
}

struct WSRequestParams {
    static let WS_REQS_PARAM_MOBILE                  = "mobile"
}

struct WSResponseParams {
    static let WS_RESP_PARAM_DATA                    = "data"
    static let WS_RESP_PARAM_ID                      = "id"
    static let WS_RESP_PARAM_MESSAGE                 = "message"
    static let WS_RESP_PARAM_ROLE                    = "role"
    static let WS_RESP_PARAM_ROLE_ID                 = "roleId"
    static let WS_RESP_PARAM_ROLE_DES                = "role_des"
    static let WS_RESP_PARAM_ROLE_IMAGE              = "role_image"
    static let WS_RESP_PARAM_SPEC_NAME               = "spec_name"
    static let WS_RESP_PARAM_STATUS                  = "status"
    static let WS_RESP_PARAM_TRUE                    = "true"
}

