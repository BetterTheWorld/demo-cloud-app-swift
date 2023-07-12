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
        static let url: String = {
            guard let token = ProcessInfo.processInfo.environment["FG_DEMO_TOKEN"] else {
                fatalError("TOKEN environment variable is missing")
            }
            return "https://cloud.almostflip.com/?token=\(token)"
        }()
    }
}
