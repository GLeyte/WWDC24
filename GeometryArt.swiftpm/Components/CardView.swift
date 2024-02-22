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
        
            GeometryReader { geometry in
                            
                let width = min(geometry.size.width, geometry.size.height)
                
                VStack(spacing:0) {
                    
                    switch curve {
                    case .curve1:
                        Curve1(a: $animation,
                               b: .constant(-0.25),
                               colorInit: .constant(Color.accentColor),
                               colorEnd: .constant(Color.accentColor),
                               precision: .constant(0.03))
                        .padding(24)
                        
                        bottomText(text: "Slinky")
                        
                    case .curve2:
                        Curve2(a: .constant(a),
                               b: .constant(-0.33),
                               n: .constant(-2.5),
                               p: .constant(32),
                               q: .constant(44),
                               r: .constant(width/3.2),
                               precision: .constant(0.03),
                               colorInit: .constant(Color.accentColor),
                               colorEnd: .constant(Color.accentColor))
                        .padding(24)
                        
                        bottomText(text: "Scrambled diamond")

                    case .curve3:
                        Curve3(a: .constant(30),
                               b: .constant(0),
                               l: .constant(l),
                               h: .constant(2),
                               precision: .constant(0.009),
                               colorInit: .constant(Color.accentColor),
                               colorEnd: .constant(Color.accentColor))
                        .padding(24)

                        bottomText(text: "Illusion torus")
                        
                    case .curve4:
                        Curve4(a: .constant(5.1),
                               b: .constant(l),
                               alpha: .constant(1),
                               beta: .constant(1),
                               precision: .constant(0.03),
                               colorInit: .constant(Color.accentColor),
                               colorEnd: .constant(Color.accentColor),
                               showEnd: .constant(false))
                        .padding(24)

                        bottomText(text: "Magic Flower")
                    }
                    
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
                    case .curve4:
                        velocidade = 1
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
            .background{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.secondary)
            }
    }
    
    func bottomText(text: String) -> some View {
        VStack(alignment:.leading) {
            latexText(text)
                .padding(8)
                .foregroundStyle(Color.accentColor)
                .font(.title3)
            
        }
    }
}

enum Curves{
    case curve1, curve2, curve3, curve4
}

#Preview {
    CardView(curve: .curve1, hasAnimation: .constant(true))
}
