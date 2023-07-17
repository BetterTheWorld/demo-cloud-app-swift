//
//  Constants.swift
//  DemoCloudSwiftApp
//
//  Created by Daniel Diaz on 10/07/23.
//

import Foundation

struct Constants {
    struct WebView {
        static let javascriptHandler = "flipgiveAppInterface"
        static let uatUrl = "https://cloud.flipgive-test.com"
        static let stageUrl = "https://cloud.almostflip.com"
        static let scriptGetWebViewMessage = "(function() { window?.webkit?.messageHandlers.flipgiveAppInterface.postMessage('USER_DATA_REQUIRED'); })()"
    }
    struct MessageTypes {
        static let optIn = "USER_DATA_REQUIRED"
        static let newWindow = "OPEN_IN_BROWSER::"
    }
}
