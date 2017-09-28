// https://github.com/Quick/Quick

import Quick
import Nimble
import ZaloSDKFramework
import ZaloSDK
class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Enum AuthenType must link to ZAZAloSDKAuthenTypeViaZalo") {
            it("raw value must equal") {
                expect(AuthenType.App.rawValue) == ZAZaloSDKAuthenTypeViaZaloAppOnly.rawValue
                expect(AuthenType.WebView.rawValue) == ZAZaloSDKAuthenTypeViaWebViewOnly.rawValue
                expect(AuthenType.AppOrWebView.rawValue) == ZAZAloSDKAuthenTypeViaZaloAppAndWebView.rawValue
            }
        }
    }
}
