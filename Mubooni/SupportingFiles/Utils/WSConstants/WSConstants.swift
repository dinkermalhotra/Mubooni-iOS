struct WebService {
    static let baseUrl                               = "https://ddfintech.in/mubooni/JSON"
    static let getUserRoles                          = "\(baseUrl)/get_user_roles/app"
    static let getUserSpecialisations                = "\(baseUrl)/get_user_specialisations/app"
}

struct WSRequestParams {
    static let WS_REQS_PARAM_MOBILE                  = "mobile"
}

struct WSResponseParams {
    static let WS_RESP_PARAM_STATUS                  = "status"
}

