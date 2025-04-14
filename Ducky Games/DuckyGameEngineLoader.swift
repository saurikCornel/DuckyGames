//
//  DuckyGameEngineLoader.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation
import SwiftUI
import WebKit

struct DuckyGameEngineLoader: UIViewRepresentable {
    @ObservedObject var vm: DuckyGodVM
    
    func makeCoordinator() -> DuckyGController {
        DuckyGController(owner: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // Настройка для отключения кэширования
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        let view = WKWebView(frame: .zero, configuration: config)
        
        
        view.backgroundColor = UIColor(hex: "#141f2b")
        view.isOpaque = false
       
        let dataTypes = Set([WKWebsiteDataTypeDiskCache,
                           WKWebsiteDataTypeMemoryCache,
                           WKWebsiteDataTypeCookies,
                           WKWebsiteDataTypeLocalStorage])
        
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes,
                                              modifiedSince: Date.distantPast) {
            debugPrint("Cache cleared on creation")
        }
        
        debugPrint("Renderer: \(vm.url)")
        view.navigationDelegate = context.coordinator
        vm.setWebView(view)
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
        // Очистка кэша при обновлении представления
        let dataTypes = Set([WKWebsiteDataTypeDiskCache,
                           WKWebsiteDataTypeMemoryCache,
                           WKWebsiteDataTypeCookies,
                           WKWebsiteDataTypeLocalStorage])
        
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes,
                                              modifiedSince: Date.distantPast) {
            debugPrint("Cache cleared on update")
        }
        
        debugPrint("RendererUpdate: \(view.url?.absoluteString ?? "nil")")
    }
}
