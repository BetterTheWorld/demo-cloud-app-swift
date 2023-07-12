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
    @State private var tokenValue = ""
    @State private var isStage = false
    @State private var isInitializated = false

    let webView: WKWebView;

    var body: some View {
        VStack {
            VStack {
                HeaderOptionsUI(title: "Awesome App",
                                onTapSendToken: {

                    if (isInitializated) {
                        injectJavaScript(javascriptCode: "(function() { window?.updateToken?.('\(tokenValue)') })()")
                        tokenValue = ""
                    }

                    if (!isInitializated && !tokenValue.isEmpty) {
                        isInitializated = true;
                    }

                },
                                onTapTriggerWebviewEvent: {
                    injectJavaScript(javascriptCode: Constants.WebView.scriptGetWebViewMessage)
                }, isToggled: $isStage, isInit: $isInitializated, inputValue: $tokenValue)
            }

            if isInitializated {
                WebViewWrapper(webView: webView)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear {
                        if !webView.configuration.userContentController.userScripts.contains(where: { $0.source.contains(Constants.WebView.javascriptHandler) }) {
                            loadURL()
                        }
                    }
            } else {
                Text("Please add init url token")
                    .font(.callout)
                    .foregroundColor(.green)
            }

        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("JavaScript Injected"), message: Text("JavaScript code has been injected!"), dismissButton: .default(Text("OK")))
        }
        .onChange(of: isStage) { newValue in
            if isInitializated {
                // reset webview state
                isInitializated = false;
                tokenValue = ""
            }
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
    
    private func loadURL() {
        // Load your desired web content using a URL
        if var urlComponents = URLComponents(string: isStage ? Constants.WebView.stageUrl : Constants.WebView.uatUrl) {
            // Add the token parameter to the URL
            let tokenQueryItem = URLQueryItem(name: "token", value: tokenValue)
            urlComponents.queryItems = [tokenQueryItem]

            if let url = urlComponents.url {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
}

struct WebViewUI_Previews: PreviewProvider {

    static var previews: some View {
        WebViewUI(webView: WKWebView())
    }
}
