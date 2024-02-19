//
//  Curve4.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 17/02/24.
//

import SwiftUI

struct Curve4: View {
        
    @Binding var a: CGFloat
    @Binding var b: CGFloat
    @Binding var alpha: CGFloat
    @Binding var beta: CGFloat
    
    @Binding var precision: Double
    
    @Binding var colorInit: Color
    @Binding var colorEnd: Color
    
    @Binding var showCircle: Bool
    @Binding var showEnd: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x:width/2, y:width/2)
            
            if showCircle {
                Circle()
                    .stroke(.gray, style: StrokeStyle(lineWidth: 2, dash: [20,10]))
                    .frame(width: width, height: width)
            }
            
            let points = cartesianCoords(width: width, center: center, iPrecision: precision)
            
            Path { path in
                
                var k = 0
                
                while k < points.count {
                    if !points[k].x.isNaN && !points[k].y.isNaN{
                        path.move(to: points[k])
                        break
                    }
                    k += 1
                }
                
                for i in (k+1)..<points.count {
                    if !points[i].x.isNaN && !points[i].y.isNaN{
                        path.addLine(to: points[i])
                    }
                }
            }
            .stroke(lineWidth: 2)
            .fill(RadialGradient(
                        gradient: Gradient(colors: [colorInit, colorEnd]),
                        center: .center,
                        startRadius: 0,
                        endRadius: width/2
                    ))
            
            if showEnd {
                Circle()
                    .frame(width: 12, height: 12)
                    .position(points.last!)
            }
            
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func cartesianCoords(width: CGFloat, center: CGPoint, iPrecision:Double) -> [CGPoint] {

        var precision:Double = 0.1
        if iPrecision != 0 {
            precision = iPrecision
        }
        
        let lmin:Double = 0
        let lmax = 3 * Double.pi
        let delta =  width/2

        var points = [CGPoint]()
        for t in stride(from: lmin, to: lmax, by: precision) {
            
            var (x, y) = curve(delta, t)

            x = max(min(x,delta),-delta)
            y = max(min(y,delta),-delta)
            
            points.append(fromCenter(x: x, y: y, center: center))
        }

        return points
    }
    
    func curve(_ r: CGFloat, _ t: Double) -> (x:CGFloat, y:CGFloat) {
        let x = r * (sin(alpha * a * t + b) * cos(t + b))
        let y = r * (sin(t + b) * cos(beta * a * t))
                        
        return (x,y)
    }
    
}
