//
//  LoaderStateGame.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation
import SwiftUI
import WebKit
import Foundation


enum DuckyLState: Equatable {
    case idle
    case loading(progress: Double)
    case loaded
    case failed(Error)
    case noInternet
    
    static func == (lhs: DuckyLState, rhs: DuckyLState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loaded, .loaded), (.noInternet, .noInternet):
            return true
        case (.loading(let lp), .loading(let rp)):
            return lp == rp
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}


