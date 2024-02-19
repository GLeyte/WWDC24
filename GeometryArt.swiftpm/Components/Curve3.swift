//
//  Curve3.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 08/02/24.
//

import SwiftUI

struct Curve3: View {
    
    @Binding var a: CGFloat
    @Binding var b: CGFloat
    
    @Binding var l: CGFloat
    @Binding var h: CGFloat
    
    var limit: CGFloat = 2 * CGFloat.pi
    @Binding var precision: Double
    
    @Binding var colorInit: Color
    @Binding var colorEnd: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x:width/2, y:width/2)
            
            Path { path in
                let points = cartesianCoords(width: width, center: center, iPrecision: precision)
                
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
            .stroke(lineWidth: 1)
            .fill(RadialGradient(
                        gradient: Gradient(colors: [colorInit, colorEnd]),
                        center: .center,
                        startRadius: 0,
                        endRadius: width/3
                    ))

            
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func cartesianCoords(width: CGFloat, center: CGPoint, iPrecision:Double) -> [CGPoint] {

        var precision:Double = 0.1
        if iPrecision != 0 {
            precision = iPrecision
        }
        
        let lmin:Double = 0
        let lmax = limit
        let delta =  width / 2

        var points = [CGPoint]()
        for t in stride(from: lmin, to: lmax, by: precision) {
            
            var (x, y) = curve(delta/4, t)

            x = max(min(x,delta),-delta)
            y = max(min(y,delta),-delta)
            
            points.append(fromCenter(x: x, y: y, center: center))
        }

        return points
    }
    
    func curve(_ r: CGFloat, _ t: Double) -> (x:CGFloat, y:CGFloat) {
        let x = r * (l * cos(t+b) - cos(a*t) * sin(t+b))
        let y = r * (h * sin(t+b) - sin(a * (t+b)))
        
        return (x, y)
    }
    
}
