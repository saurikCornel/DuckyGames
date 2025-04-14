//
//  DuckyGodVM.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation
import SwiftUI
import WebKit

class DuckyGodVM: ObservableObject {
    @Published var lstate: DuckyLState = .idle
    let url: URL
    private var duckyScene: WKWebView?
    private var rhf: NSKeyValueObservation?
    private var complete: Double = 0.0
   
    
    init(url: URL) {
        self.url = url
        
    }
    
    func setWebView(_ webView: WKWebView) {
        self.duckyScene = webView
        observeLoading(webView)
        loadDucky()
       
    }
    
    func loadDucky() {
        guard let webView = duckyScene else {
         
            return
        }
        let request = URLRequest(url: url, timeoutInterval: 15.0)
      
       
        DispatchQueue.main.async { [weak self] in
            self?.lstate = .loading(progress: 0.0)
            self?.complete = 0.0
        }
        webView.load(request)
    }
    
    private func observeLoading(_ webView: WKWebView) {
        rhf = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            let progress = webView.estimatedProgress
           
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if progress > self.complete {
                    self.complete = progress
                    self.lstate = .loading(progress: self.complete)
                }
                if progress >= 1.0 {
                    self.lstate = .loaded
                }
            }
        }
    }
    
    func updateNetworkStatus(_ isConnected: Bool) {
        if isConnected && lstate == .noInternet {
            loadDucky()
        } else if !isConnected {
            DispatchQueue.main.async { [weak self] in
                self?.lstate = .noInternet
            }
        }
       
    }
}
