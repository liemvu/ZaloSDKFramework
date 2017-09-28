import ZaloSDK

@objc public class ZaloSDKFramework: NSObject {
    fileprivate let sdk: ZaloSDK
    public static let sharedInstance = ZaloSDKFramework()
    
    public override init() {
        sdk = ZaloSDK.sharedInstance()
    }
    
    /// 0a. Inititlize with app id
    public func initialize(appId: String) {
        sdk.initialize(withAppId: appId)
    }
    
    /// 0b. Call this func in app delegate
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ZDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

extension ZaloSDKFramework {
    /// 1. Authenticate
    /// controller: The current login controller
    /// type: login by zalo app / web view, default: both
    /// callback: when login completed
    public func authenticate(from controller: UIViewController, type: AuthenType = .AppOrWebView, callback: @escaping AuthenCallback) {
        let zatype = ZAZaloSDKAuthenType(rawValue: type.rawValue)
        sdk.authenticateZalo(with: zatype, parentController: controller) { (obj) in
            callback(obj ?? ZOOauthResponseObject.init(unknowExceptionResponseObject: ()))
        }
    }
    
    /// Check if current user authenticated
    /// return: true if oauth code has been cached, but still need to verify with server
     @discardableResult public func isAuthenticated(callback: @escaping AuthenCallback) -> Bool {
        return sdk.isAuthenticatedZalo { (obj) in
            callback(obj ?? ZOOauthResponseObject.init(unknowExceptionResponseObject: ()))
        }
    }
    
    /// Logout, clear cached oauth code
    public func unauthenticate() {
        sdk.unauthenticate()
    }
}

extension ZaloSDKFramework {
    /// 2. Get Zalo user profile
    public func userProfile(callback: @escaping GraphCallback) {
        sdk.getZaloUserProfile { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    /**
     Get Zalo user friends who also using this app
     */
    public func getUserFriendList(from offset: UInt = 0, limit: UInt = 50, callback: @escaping GraphCallback) {
        sdk.getUserFriendList(atOffset: offset, count: limit) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    /**
     Get invitable Zalo user friends by offset and count
     */
    public func getUserInvitableFriendList(from offset: UInt = 0, limit: UInt = 50, callback: @escaping GraphCallback) {
        sdk.getUserInvitableFriendList(atOffset: offset, count: limit) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    
    /**
     Post feed
     */
    public func postFeed(withMessage message: String, link: String? = nil, callback: @escaping GraphCallback){
        sdk.postFeed(withMessage: message, link: link) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    
    /**
     Invite other user to use app
     */
    public func sendAppRequest(to friendId: String, message: String, callback: @escaping GraphCallback){
        sdk.sendAppRequest(to: friendId, message: message) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    
    /**
     Send message to a friend
     */
    public func sendMessage(to friendId: String, message: String, link: String? = nil, callback: @escaping GraphCallback){
        sdk.sendMessage(to: friendId, message: message, link: link) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    
    /**
     Send message onbehave of offical account
     */
    public func sendOfficalAccountMessage(with template: String, templateData: [String : Any], callback: @escaping GraphCallback){
        sdk.sendOfficalAccountMessage(with: template, templateData: templateData) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }
    
    
    /**
     Send graph api request with specific path and param
     Path: graph path ie: /me
     Param: url query param
     Method: HttpMethod: GET / POST
     */
    public func userGraph(withPath path: String, params data: [AnyHashable : Any], method: String = "GET", callback: @escaping GraphCallback) {
        sdk.userGraph(withPath: path, params: data, method: method) { (response) in
            callback(response ?? GraphResponse.init(unknowExceptionResponseObject: ()))
        }
    }

}

extension ZaloSDKFramework {
    public var version: String {
        return sdk.version()
    }
    
    public var zaloOauthCode: String? {
        return sdk.zaloOauthCode()
    }
    
    public var zaloUserId: String? {
        return sdk.zaloUserId()
    }
}


@objc public enum AuthenType: UInt32 {
    case App, WebView, AppOrWebView
}
public typealias AuthenResponse = ZOOauthResponseObject
public typealias GraphResponse = ZOGraphResponseObject
public typealias AuthenCallback = (AuthenResponse) -> Void
public typealias GraphCallback = (GraphResponse) -> Void
