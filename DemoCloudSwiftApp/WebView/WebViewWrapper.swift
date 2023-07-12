//
//  WebViewWrapper.swift
//  DemoCloudSwiftApp
//
//  Created by Daniel Diaz on 10/07/23.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    let webView: WKWebView

    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: WebViewWrapper

        init(_ parent: WebViewWrapper) {
            self.parent = parent
            let webConfiguration = WKWebpagePreferences()
            webConfiguration.allowsContentJavaScript = true
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == Constants.WebView.javascriptHandler {
                if let messageBody = message.body as? String {
                    // Handle the received message from the web view
                    showAlert(message: "Received message from web view: \(messageBody) . Please, send new authentication token.")
                } else if let messageBody = message.body as? [String: Any] {
                    // Handle the received message as a dictionary
                    showAlert(message: "Received message as dictionary from web view: \(messageBody) . Please, send new authentication token.")
                } else {
                    // Handle unsupported type gracefully
                    showAlert(message: "Received message of unsupported type from web view")
                }
            }
        }
        
        func showAlert(message: String) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first,
                  let viewController = window.rootViewController else {
                return
            }
            
            let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.isInspectable = true
        let userContentController = webView.configuration.userContentController
        
        // Remove the existing script message handler if it exists
        let scriptName = Constants.WebView.javascriptHandler
        userContentController.removeScriptMessageHandler(forName: scriptName)
        
        // Add the script message handler
        userContentController.add(context.coordinator, name: scriptName)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No updates needed
    }
}

