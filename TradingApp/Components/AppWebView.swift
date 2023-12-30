//
//  AppWebView.swift
//  TradingApp
//
//  Created by Стас Ильиных on 02.12.2023.
//

import Foundation
import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    
    init (url: String) {
        self.url = url
    }
}

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
            
            if let cookie = HTTPCookie(properties: [
                .domain: "TraderAppCookie.com",
                .path: "/",
                .name: "TraderAppCookie",
                .value: "TraderAppCookieValue",
                .secure: "TRUE",
                .expires: NSDate(timeIntervalSinceNow: 31556926)
            ]) {
                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) {
        let cookies = HTTPCookieStorage.shared.cookies ?? []
        for cookie in cookies {
            webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
        }
    }
    
    func reload() {
        webView.reload()
    }
    
    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator
        self.webView.allowsBackForwardNavigationGestures = true

        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }

        return self.webView
    }
}
