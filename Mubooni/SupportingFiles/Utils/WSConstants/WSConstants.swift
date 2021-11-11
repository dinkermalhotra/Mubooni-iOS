struct WebService {
    static let baseUrl                               = "https://ddfintech.in/mubooni/JSON"
    static let baseImageUrl                          = "https://ddfintech.in/mubooni/"
    static let checkFacebookIdExist                  = "\(baseUrl)/checkFacebookId/app"
    static let checkGoogleIdExist                    = "\(baseUrl)/checkGoogleId/app"
    static let getFeaturedProperties                 = "\(baseUrl)/get_all_FeaturedProperties/app/"
    static let getUserProperties                     = "\(baseUrl)/get_all_user_properties/app/"
    static let getUserRoles                          = "\(baseUrl)/get_user_roles/app"
    static let getUserSpecialisations                = "\(baseUrl)/get_user_specialisations/app"
    static let loginUser                             = "\(baseUrl)/loginMe/app"
}

struct WSRequestParams {
    static let WS_REQS_PARAM_EMAIL                   = "email"
    static let WS_REQS_PARAM_FACEBOOK_EMAIL          = "facebook_email"
    static let WS_REQS_PARAM_FACEBOOK_ID             = "facebook_id"
    static let WS_REQS_PARAM_FEATURED_STATUS         = "featured_status"
    static let WS_REQS_PARAM_GOOGLE_EMAIL            = "google_email"
    static let WS_REQS_PARAM_GOOGLE_ID               = "google_id"
    static let WS_REQS_PARAM_LOG_USERID              = "log_userId"
    static let WS_REQS_PARAM_PASSWORD                = "password"
}

struct WSResponseParams {
    static let WS_RESP_PARAM_ADDRESS                 = "address"
    static let WS_RESP_PARAM_APP_ATTACHMENTS         = "app_attachments"
    static let WS_RESP_PARAM_DATA                    = "data"
    static let WS_RESP_PARAM_EMAIL                   = "email"
    static let WS_RESP_PARAM_FEATURED_STATUS         = "featured_status"
    static let WS_RESP_PARAM_ID                      = "id"
    static let WS_RESP_PARAM_IMG                     = "img"
    static let WS_RESP_PARAM_MESSAGE                 = "message"
    static let WS_RESP_PARAM_MONTHLY_RENT            = "monthly_rent"
    static let WS_RESP_PARAM_NAME                    = "name"
    static let WS_RESP_PARAM_ROLE                    = "role"
    static let WS_RESP_PARAM_ROLE_ID                 = "roleId"
    static let WS_RESP_PARAM_ROLE_DES                = "role_des"
    static let WS_RESP_PARAM_ROLE_IMAGE              = "role_image"
    static let WS_RESP_PARAM_SPEC_NAME               = "spec_name"
    static let WS_RESP_PARAM_STATUS                  = "status"
    static let WS_RESP_PARAM_TRUE                    = "true"
    static let WS_RESP_PARAM_TYPE_NAME               = "type_name"
    static let WS_RESP_PARAM_UNIT_STATUS             = "unit_status"
    static let WS_RESP_PARAM_UNIT_TYPE               = "unit_type"
    static let WS_RESP_PARAM_UNITS                   = "units"
    static let WS_RESP_PARAM_USER_ID                 = "userId"
}

