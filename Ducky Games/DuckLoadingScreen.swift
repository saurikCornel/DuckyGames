//
//  GameLoaderHelper.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation
import SwiftUI



struct DuckLoadingScreen: View {
    @StateObject var duckyVM: DuckyGodVM
    
    init(ctrl: DuckyGodVM) {
        _duckyVM = StateObject(wrappedValue: ctrl)
    }
    
    var body: some View {
        ZStack {
            DuckyGameEngineLoader(vm: duckyVM)
            .opacity(duckyVM.lstate == .loaded ? 1 : 0.5)
            if case .loading(let p) = duckyVM.lstate {
                GeometryReader { geo in
                    DuckySpinner(progress: p)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(Color.black)
                }
            } else if case .failed(let e) = duckyVM.lstate {
                Text("Error: \(e.localizedDescription)").foregroundColor(.red)
            } else if case .noInternet = duckyVM.lstate {
                Text("")
            }
        }
    }
}
