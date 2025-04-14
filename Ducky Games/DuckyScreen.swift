//
//  MainScreen.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation

import SwiftUI

struct DuckyScreen: View {
    let url: URL = .init(string: "https://duckygamesplus.top/play/")!
    var body: some View {
        DuckLoadingScreen(ctrl: .init(url: url))
            .background(Color(hex: "#671f61").ignoresSafeArea())
    }
}


extension Color {
    init?(hex: String) {
        
        let trimmedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let cleanedHex = trimmedHex.hasPrefix("#") ? String(trimmedHex.dropFirst()) : trimmedHex
      
        guard cleanedHex.count == 3 || cleanedHex.count == 6 else {
            return nil
        }
        
        let finalHex: String
        if cleanedHex.count == 3 {
          
            finalHex = cleanedHex.map { String($0) + String($0) }.joined()
        } else {
         
            finalHex = cleanedHex
        }
        
      
        let scanner = Scanner(string: finalHex)
        var value: UInt32 = 0
        guard scanner.scanHexInt32(&value) else {
            return nil
        }
        
       
        let red = Double((value >> 16) & 0xFF) / 255.0
        let green = Double((value >> 8) & 0xFF) / 255.0
        let blue = Double(value & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}





#Preview {
    DuckyScreen()
}
