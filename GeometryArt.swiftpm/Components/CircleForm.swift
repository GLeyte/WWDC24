//
//  CircleForm.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI

struct C: View {
    
    @Binding var valor: CGFloat
    @Binding var division: Int
    @Binding var colorInit: Color
    @Binding var colorEnd: Color
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                let width = min(geometry.size.width, geometry.size.height)
                
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundStyle(.white)
                    .frame(width: width, height: width)
                
                let r = width/2 - 2
                let center = CGPoint(x:width/2, y:width/2)
                let divAngle = 360/CGFloat(division)
                                
                Path { path in
                    
                    for i in 0..<division {
                        
                        let x = CGFloat(i)
                        let y = valor <= CGFloat(division)/2 ? x + valor : x + valor * x.truncatingRemainder(dividingBy: 2) + valor
                        
                        
                        let inicio = xyPosition(position: x, r: r, divAngle: divAngle, center: center)
                        let fim = xyPosition(position: y, r: r, divAngle: divAngle, center: center)
                        
                        path.move(to: inicio)
                        path.addLine(to: fim)
                    }
                    path.closeSubpath()
                }
                .stroke(lineWidth: 1)
                .fill(RadialGradient(
                            gradient: Gradient(colors: [colorInit, colorEnd]),
                            center: .center,
                            startRadius: width/20,
                            endRadius: width/2.5
                        ))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func xyPosition(position: CGFloat, r: CGFloat, divAngle: CGFloat, center: CGPoint) -> CGPoint {
        fromCenter(
            x: r * cos(deg2rad(CGFloat(CGFloat(divAngle) * position))),
            y: r * sin(deg2rad(CGFloat(CGFloat(divAngle) * position))),
            center: center
        )
    }
}
