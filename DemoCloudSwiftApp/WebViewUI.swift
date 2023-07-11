//
//  WebViewUI.swift
//  DemoCloudSwiftApp
//
//  Created by Daniel Diaz on 10/07/23.
//

import SwiftUI
import WebKit

struct WebViewUI: View {
    @State private var showAlert = false
    @State private var token: String = ""
    @State private var tokenValue = ""

    let webView: WKWebView;
    let contentURL: URL;

    var body: some View {
        VStack {
            VStack {
                HeaderOptionsUI(title: "Awesome App",
                                onTapSendToken: {
                    injectJavaScript(javascriptCode: "(function() { window.updateToken('\(tokenValue)') })()")
                },
                                onTapTriggerWebviewEvent: {
                    injectJavaScript(javascriptCode: "(function() { window?.webkit?.messageHandlers.flipgiveAppInterface.postMessage('USER_DATA_REQUIRED'); })()")
                }, inputValue: $tokenValue)
            }
            WebViewWrapper(webView: webView, contentURL: contentURL)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    if !webView.configuration.userContentController.userScripts.contains(where: { $0.source.contains(Constants.WebView.javascriptHandler) }) {
                        webView.load(URLRequest(url: contentURL))
                    }
                }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("JavaScript Injected"), message: Text("JavaScript code has been injected!"), dismissButton: .default(Text("OK")))
        }
    }

    private func injectJavaScript(javascriptCode: String) {
        // Access the WKWebView instance here (e.g., via @State or @ObservedObject)
        // Assuming webView is the WKWebView instance
        
        webView.evaluateJavaScript(javascriptCode) { result, error in
            if let error = error {
                print("JavaScript evaluation error: \(error)")
            } else {
                showAlert = true
                // JavaScript code executed successfully
            }
        }
    }
}

struct WebViewUI_Previews: PreviewProvider {

    static var previews: some View {
        WebViewUI(webView: WKWebView(), contentURL: URL(string: Constants.WebView.url)!)
    }
}
