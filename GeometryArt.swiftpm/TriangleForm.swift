//
//  TriangleForm.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI

struct TriangleForm: View {
    
    @Binding var valor: CGFloat
    @Binding var division: Int
    @Binding var colorInit: Color
    @Binding var colorEnd: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let r = width/2 - 2
            let center = CGPoint(x:width/2, y:width/2)
            let anguloBase = 120
            let divAngle = CGFloat(360)/CGFloat(division)
            
            // Triangle lines
            Path { path in
                
                for i in 0..<division {
                    
                    let x = CGFloat(i)
                    let y = x + valor + valor * x.truncatingRemainder(dividingBy: 2)
                    
                    let inicio = xyPosition(position: x, r: r, divAngle: divAngle, center: center)
                    let fim = xyPosition(position: y, r: r, divAngle: divAngle, center: center)
                    
                    path.move(to: inicio)
                    path.addLine(to: fim)
                }
                
            }
            .stroke(lineWidth: 1)
            .fill(RadialGradient(
                        gradient: Gradient(colors: [colorInit, colorEnd]),
                        center: .center,
                        startRadius: width/20,
                        endRadius: width/2.5
                    ))
            
            // Triangle back
            Path { path in
                
                var vertices = [CGPoint]()
                
                for aux in 0..<3 {
                    let vertice = fromCenter(x: r * cos(deg2rad(CGFloat(90 + anguloBase * aux))), y: r * sin(deg2rad(CGFloat(90 + anguloBase * aux))), center: center)
                    vertices.append(vertice)
                }
                
                path.move(to: vertices[0])
                for num in 1..<vertices.count {
                    path.addLine(to: vertices[num])
                }
                path.closeSubpath()

            }
            .stroke(lineWidth: 3)
            .fill(.white)
            
        }
        .aspectRatio(1, contentMode: .fit)
        
    }
    
    func xyPosition(position: CGFloat, r: CGFloat, divAngle: CGFloat, center: CGPoint) -> CGPoint {
        
        let theta = deg2rad(CGFloat(CGFloat(divAngle) * position)).truncatingRemainder(dividingBy: 2 * CGFloat.pi)
        let angle = abs(theta - 11 * CGFloat.pi / 6) - abs(theta - 7 * CGFloat.pi / 6) + abs(theta - CGFloat.pi / 2) - CGFloat.pi
        
        let r = r / (2 * cos(angle))
        
        return fromCenter(
            x: r * cos(deg2rad(CGFloat(CGFloat(divAngle) * position))),
            y: r * sin(deg2rad(CGFloat(CGFloat(divAngle) * position))),
            center: center
        )

    }
}

