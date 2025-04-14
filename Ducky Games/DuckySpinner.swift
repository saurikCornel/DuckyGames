//
//  DynamicLoader.swift
//  Ducky Games +
//
//  Created by alex on 4/14/25.
//

import Foundation

import SwiftUI


struct DuckySpinner: View {
    var progress: Double
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.8))
                            .frame(width: 80, height: 80)
                        
                        Circle()
                            .trim(from: 0.0, to: 0.7)
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                            .frame(width: 60, height: 60)
                            .rotationEffect(Angle(degrees: rotationAngle))
                            .animation(
                                Animation.easeInOut(duration: 2)
                                    .repeatForever(autoreverses: false),
                                value: rotationAngle
                            )
                            .onAppear {
                                rotationAngle = 360
                            }
                        
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(width: geometry.size.width)
            .background(
                Image(.bg)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    DuckySpinner(progress: 0.75)
}

