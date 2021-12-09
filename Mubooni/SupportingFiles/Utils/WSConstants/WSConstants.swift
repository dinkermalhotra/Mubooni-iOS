struct WebService {
    static let baseUrl                               = "https://ddfintech.in/mubooni/JSON"
    static let baseImageUrl                          = "https://ddfintech.in/mubooni/"
    static let checkFacebookIdExist                  = "\(baseUrl)/checkFacebookId/app"
    static let checkGoogleIdExist                    = "\(baseUrl)/checkGoogleId/app"
    static let getAgentJobs                          = "\(baseUrl)/get_all_AgentJobs/app/"
    static let getAgentReports                       = "\(baseUrl)/get_AgentPayments_reports/app/"
    static let getAgentTenants                       = "\(baseUrl)/get_AllTenant_list/app/"
    static let getAreaType                           = "\(baseUrl)/get_all_area_types/app/"
    static let getFeaturedProperties                 = "\(baseUrl)/get_all_FeaturedProperties/app/"
    static let getFilteredProperties                 = "\(baseUrl)/get_all_properties/app"
    static let getPropertiesOnMap                    = "\(baseUrl)/get_all_localProperties/app/"
    static let getPropertyTypes                      = "\(baseUrl)/get_all_property_types/app/"
    static let getServiceProviders                   = "\(baseUrl)/get_all_ServicesProviders/app/"
    static let getUserProfile                        = "\(baseUrl)/get_user_info/app/"
    static let getUserProperties                     = "\(baseUrl)/get_all_user_properties/app/"
    static let getUserRoles                          = "\(baseUrl)/get_user_roles/app"
    static let getUserSpecialisations                = "\(baseUrl)/get_user_specialisations/app"
    static let getUnitType                           = "\(baseUrl)/get_all_unit_types/app/"
    static let loginUser                             = "\(baseUrl)/loginMe/app"
    static let searchServiceProviders                = "\(baseUrl)/get_searched_ServicesProviders/app/"
}

struct WSRequestParams {
    static let WS_REQS_PARAM_AREA                    = "area"
    static let WS_REQS_PARAM_DISTANCE                = "distance"
    static let WS_REQS_PARAM_EMAIL                   = "email"
    static let WS_REQS_PARAM_ESTATE_TYPE             = "estate_type"
    static let WS_REQS_PARAM_FACEBOOK_EMAIL          = "facebook_email"
    static let WS_REQS_PARAM_FACEBOOK_ID             = "facebook_id"
    static let WS_REQS_PARAM_FEATURED_STATUS         = "featured_status"
    static let WS_REQS_PARAM_GOOGLE_EMAIL            = "google_email"
    static let WS_REQS_PARAM_GOOGLE_ID               = "google_id"
    static let WS_REQS_PARAM_INDEX                   = "index"
    static let WS_REQS_PARAM_LAT                     = "lat"
    static let WS_REQS_PARAM_LNG                     = "lng"
    static let WS_REQS_PARAM_LOCATION_SPEC           = "location_spec"
    static let WS_REQS_PARAM_LOG_USERID              = "log_userId"
    static let WS_REQS_PARAM_PAGE_TYPE               = "pageType"
    static let WS_REQS_PARAM_PASSWORD                = "password"
    static let WS_REQS_PARAM_PRICE                   = "price"
    static let WS_REQS_PARAM_REG_TYPE                = "reg_type"
    static let WS_REQS_PARAM_SEARCHED                = "searched"
    static let WS_REQS_PARAM_SEARCHED_SPECS          = "searched_spec"
    static let WS_REQS_PARAM_UNIT_STATUS             = "unitStatus"
    static let WS_REQS_PARAM_UNIT_TYPE               = "unit_type"
}

struct WSResponseParams {
    static let WS_RESP_PARAM_ABOUT                   = "about"
    static let WS_RESP_PARAM_ADDRESS                 = "address"
    static let WS_RESP_PARAM_AGENT_ID                = "agent_id"
    static let WS_RESP_PARAM_AMOUNT                  = "amount"
    static let WS_RESP_PARAM_APP_ATTACHMENTS         = "app_attachments"
    static let WS_RESP_PARAM_AREA_ID                 = "area_id"
    static let WS_RESP_PARAM_AREA_SIZE_NAME          = "area_size_name"
    static let WS_RESP_PARAM_ATTACHED_DOC            = "attached_doc"
    static let WS_RESP_PARAM_COUNTRY_CODE            = "country_code"
    static let WS_RESP_PARAM_DATA                    = "data"
    static let WS_RESP_PARAM_EMAIL                   = "email"
    static let WS_RESP_PARAM_ESTATE_ID               = "estate_id"
    static let WS_RESP_PARAM_ESTATE_NAME             = "estate_name"
    static let WS_RESP_PARAM_ESTATE_SIZE_TYPE        = "estate_size_type"
    static let WS_RESP_PARAM_ESTATE_TYPE             = "estate_type"
    static let WS_RESP_PARAM_FACEBOOK_ID             = "facebook_id"
    static let WS_RESP_PARAM_FEATURED_STATUS         = "featured_status"
    static let WS_RESP_PARAM_GOOGLE_ID               = "google_id"
    static let WS_RESP_PARAM_ID                      = "id"
    static let WS_RESP_PARAM_ID_PROOF                = "id_proof"
    static let WS_RESP_PARAM_IMG                     = "img"
    static let WS_RESP_PARAM_INVOICE_STATUS          = "invoice_status"
    static let WS_RESP_PARAM_IS_PHONE_VERIFY         = "isphone_verify"
    static let WS_RESP_PARAM_IS_USER_VERIFY          = "isUserVerify"
    static let WS_RESP_PARAM_IS_VERIFY               = "isverify"
    static let WS_RESP_PARAM_JOB_ABILITY             = "job_ability"
    static let WS_RESP_PARAM_JOB_STATUS              = "job_status"
    static let WS_RESP_PARAM_KENYA_ID                = "kenya_id"
    static let WS_RESP_PARAM_LAT                     = "lat"
    static let WS_RESP_PARAM_LNG                     = "lng"
    static let WS_RESP_PARAM_MESSAGE                 = "message"
    static let WS_RESP_PARAM_MOBILE                  = "mobile"
    static let WS_RESP_PARAM_MONTHLY_RENT            = "monthly_rent"
    static let WS_RESP_PARAM_NAME                    = "name"
    static let WS_RESP_PARAM_OWNER_NAME              = "owner_name"
    static let WS_RESP_PARAM_OWNER_NOTES             = "owner_notes"
    static let WS_RESP_PARAM_PAID_DATE               = "paid_date"
    static let WS_RESP_PARAM_PAY_STATUS              = "pay_status"
    static let WS_RESP_PARAM_PER_DAY                 = "per_day"
    static let WS_RESP_PARAM_PROBLEM_DESCRIPTION     = "problem_description"
    static let WS_RESP_PARAM_PROFILE                 = "profile"
    static let WS_RESP_PARAM_PROPERTY_ADDRESS        = "property_address"
    static let WS_RESP_PARAM_REQUEST_DATE            = "request_date"
    static let WS_RESP_PARAM_ROLE                    = "role"
    static let WS_RESP_PARAM_ROLE_ID                 = "roleId"
    static let WS_RESP_PARAM_ROLE_DES                = "role_des"
    static let WS_RESP_PARAM_ROLE_IMAGE              = "role_image"
    static let WS_RESP_PARAM_STAY_DAYS               = "stay_days"
    static let WS_RESP_PARAM_SUB_ROLE                = "sub_role"
    static let WS_RESP_PARAM_SPECIALISATIONS         = "specialisations"
    static let WS_RESP_PARAM_SPEC_NAME               = "spec_name"
    static let WS_RESP_PARAM_STATUS                  = "status"
    static let WS_RESP_PARAM_TENANT_NAME             = "tenant_name"
    static let WS_RESP_PARAM_TRUE                    = "true"
    static let WS_RESP_PARAM_TYPE_NAME               = "type_name"
    static let WS_RESP_PARAM_UNIT_NAME               = "unit_name"
    static let WS_RESP_PARAM_UNIT_NUMBER             = "unit_no"
    static let WS_RESP_PARAM_UNIT_STATUS             = "unit_status"
    static let WS_RESP_PARAM_UNIT_TYPE               = "unit_type"
    static let WS_RESP_PARAM_UNITS                   = "units"
    static let WS_RESP_PARAM_USER_ID                 = "userId"
}

