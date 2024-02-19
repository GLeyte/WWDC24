//
//  Curve2.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI

struct Curve2: View {
    
    @Binding var a: CGFloat
    @Binding var b: CGFloat
    @Binding var n: Double
    @Binding var p: Int
    @Binding var q: Int
    @Binding var r: CGFloat
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
        let lmax = 10 * Double.pi
        let delta =  width/2

        var points = [CGPoint]()
        for t in stride(from: lmin, to: lmax, by: precision) {
            
            var (x, y) = curve(r, t)

            x = max(min(x,delta),-delta)
            y = max(min(y,delta),-delta)
            
            points.append(fromCenter(x: x, y: y, center: center))
        }

        return points
    }
    
    func curve(_ r: CGFloat, _ t: Double) -> (x:CGFloat, y:CGFloat) {
        
        let coss = cos(n * (t - b))
        let seno = sin(n * (t - b))
        
        let cosP = coss >= 0 ? pow(coss, Double(p)/10) : pow(-1, Double(p)) * pow(-coss, Double(p)/10)
        let sinQ = seno >= 0 ? pow(seno,  Double(q)/10) : pow(-1, Double(q)) * pow(-seno,  Double(q)/10)
        
        let x = r * (2.5 * b + cosP) * cos(t + a)
        let y = r * (2.5 * b + sinQ) * sin(t + a)
                
        return (x,y)
    }
    
}

#Preview {
    Curve2(a: .constant(-10),
           b: .constant(-0.33),
           n: .constant(-2.5),
           p: .constant(32),
           q: .constant(44),
           r: .constant(200),
           precision: .constant(0.03),
           colorInit: .constant(.cyan),
           colorEnd: .constant(.pink))
    .background(.black)
}
