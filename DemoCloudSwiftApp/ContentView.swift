//
//  ContentView.swift
//  DemoCloudSwiftApp
//
//  Created by Daniel Diaz on 10/07/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Native Swift Demo app")

                NavigationLink(destination: WebViewUI(webView: WKWebView())) {
                    Text("Go to WebView")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
