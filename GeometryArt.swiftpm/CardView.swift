//
//  CardView.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 15/02/24.
//

import SwiftUI

struct CardView: View {
    
    let curve: Curves
    let limit:CGFloat = CGFloat.pi * 2
    
    let accentColor = Color(red: 57/255, green: 255/255, blue: 20/255)
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var timerData = TimerData()
    
    @State private var animation:CGFloat = 0.1
    @State private var directionRight = true
    
    @Binding var hasAnimation: Bool
    
    private var l: CGFloat {
        return animation * 2 / CGFloat.pi - 2
    }
    
    private var a: CGFloat {
        return animation * 5 / CGFloat.pi - 10
    }
    
    var body: some View {
        
        let color1:Color = .white
        let color2:Color = colorScheme == .dark ? .black : .white
        
        GeometryReader { geometry in
                        
            let width = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                
                switch curve {
                case .curve1:
                    Curve1(a: $animation,
                           b: .constant(-0.25),
                           colorInit: .constant(accentColor),
                           colorEnd: .constant(accentColor),
                           precision: .constant(0.03))
                    .padding(12)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color1, lineWidth: 2)
                            .frame(width: width + 16, height: width + 16)
                    }
                case .curve2:
                    Curve2(a: .constant(a),
                           b: .constant(-0.33),
                           n: .constant(-2.5),
                           p: .constant(32),
                           q: .constant(44),
                           r: .constant(width/2), 
                           precision: .constant(0.03),
                           colorInit: .constant(color1),
                           colorEnd: .constant(color1))
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color1, lineWidth: 2)
                            .frame(width: width + 16, height: width + 16)
                    }
                case .curve3:
                    Curve3(a: .constant(30),
                           b: .constant(0),
                           l: .constant(l),
                           h: .constant(2),
                           precision: .constant(0.01),
                           colorInit: .constant(color1),
                           colorEnd: .constant(color1))
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(accentColor, lineWidth: 2)
                            .frame(width: width + 16, height: width + 16)
                    }
                }
                
                
                VStack {
                    
                    Spacer()
                    
                    switch curve {
                    case .curve1:
                        
                        VStack(alignment:.leading) {
                            latexText("Slinky")
                                .padding(8)
                                .foregroundStyle(color2)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .bottom)
                                .background(color1)
                                .clipShape(
                                    .rect(
                                        bottomLeadingRadius: 16,
                                        bottomTrailingRadius: 16
                                    )
                                )
                            
                        }.offset(y: 12.0)
                        
                    case .curve2:
                        VStack(alignment:.leading) {
                            latexText("Scrambled diamond")
                                .padding(8)
                                .foregroundStyle(color1)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .bottom)
                                .background(color1)
                                .clipShape(
                                    .rect(
                                        bottomLeadingRadius: 16,
                                        bottomTrailingRadius: 16
                                    )
                                )
                            
                        }.offset(y: 12.0)
                    case .curve3:
                        VStack(alignment:.leading) {
                            latexText("Curva 3")
                                .padding(8)
                                .foregroundStyle(color2)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .bottom)
                                .background(accentColor)
                                .clipShape(
                                    .rect(
                                        bottomLeadingRadius: 16,
                                        bottomTrailingRadius: 16
                                    )
                                )
                            
                        }.offset(y: 12.0)
                    }
                    
                }
                .frame(minWidth: width + 16, maxWidth: width + 16, maxHeight: width)
            }
            .frame(maxWidth: .infinity)
            .onReceive(timerData.timer) { _ in
                
                var velocidade:CGFloat = 1
                
                switch curve {
                case .curve1:
                    velocidade = 0.15
                case .curve2:
                    velocidade = 0.5
                case .curve3:
                    velocidade = 2
                }
                
                if hasAnimation {
                    
                    if directionRight {
                        animation += 0.01 * velocidade
                        if animation > limit {
                            directionRight = false
                        }
                    } else {
                        animation -= 0.01 * velocidade
                        if animation <= 0 {
                            directionRight = true
                        }
                    }
                }
                
            }
        }
    }
}

enum Curves{
    case curve1, curve2, curve3
}

#Preview {
    CardView(curve: .curve1, hasAnimation: .constant(true))
}
