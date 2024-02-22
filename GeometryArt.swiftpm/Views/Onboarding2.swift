//
//  Onboarding2.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 06/02/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Onboarding2: View {
        
    var body: some View {
                    
            VStack(alignment: .leading, spacing:32) {
                
                VStack {
                    latexText("What kind of equation do we normally use?")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing:16){
                    latexText("Rectangular equation")
                        .font(.title3)
                        .bold()
                    
                    latexText("Is in this situation that parametric equations come in.  They work through the parameterization of x and y in relation to a third variable t, i.e. x = f(t) and y = g(t).")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Rectangle().foregroundStyle(.clear).frame(height: 5)
                    
                    HStack(spacing:8) {
                        VStack(spacing: 8) {
                            latexText("Choose")
                            LaTeX("x")
                                .parsingMode(.all)
                        }
                        
                        LaTeX("\\rightarrow")
                            .parsingMode(.all)
                        
                        VStack(spacing: 8) {
                            latexText("Find y using f")
                                .multilineTextAlignment(.center)
                            LaTeX("y = f(x)")
                                .parsingMode(.all)
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        
                        LaTeX("\\rightarrow")
                            .parsingMode(.all)
                        
                        VStack(spacing: 8) {
                            latexText("Plot point")
                            LaTeX("(x,y)")
                                .parsingMode(.all)
                        }
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(lineWidth: 1)
                    )
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    latexText("Example")
                        .font(.title3)
                        .bold()
                    
                    HStack {
                        LaTeX("x=2")
                            .parsingMode(.all)
                        
                        LaTeX("\\longrightarrow")
                            .parsingMode(.all)
                        
                        LaTeX("y=x^2 = 4")
                            .parsingMode(.all)
                        
                        LaTeX("\\longrightarrow")
                            .parsingMode(.all)
                        
                        LaTeX("(2,4)")
                            .parsingMode(.all)
                        
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(lineWidth: 1)
                    )

                } 
                
                Spacer()
                
                NavigationLink(value: Views.onboarding3) {
                    
                    latexText("Continue")
                        .padding()
                        .foregroundStyle(.black)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                    
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
}

#Preview {
    Onboarding2()
}

struct Onboarding1Curve: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x:0, y:width)
            
            ZStack {
                
                let points = cartesianCoords(width: width, center: center, iPrecision: 0.01)
                
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
                .stroke(.blue, lineWidth: 2)
                
                Path { path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: width))
                    path.addLine(to: CGPoint(x: width, y: width))
                }
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 2)
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 5, y: 10))
                    path.addLine(to: CGPoint(x: -5, y: 10))
                    path.closeSubpath()
                    
                }.fill(colorScheme == .dark ? .white : .black)
                
                Path { path in
                    path.move(to: CGPoint(x: width, y: width))
                    path.addLine(to: CGPoint(x: width - 10, y: width - 5))
                    path.addLine(to: CGPoint(x: width - 10, y: width + 5))
                    path.closeSubpath()
                    
                }.fill(colorScheme == .dark ? .white : .black)
                
                LaTeX("$f(x) = x^2$")
                    .position(x: -50, y: width/2)
                    .font(.footnote)
                
                ForEach(0..<3) { inde in
                    
                    if abs(width - 64) > 0.1 {
                        
                        let total = points.count
                        let aux = inde
                        let ind = Int(total/5) * inde + Int(total / 2)
                        let point = points[ind]
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                            .position(point)
                        
                        if aux == 0 {
                            Text("(\(to2Digits(0.5, digits: 1)), \(to2Digits(0.25, digits: 2)))")
                                .position(x: point.x + 30, y: point.y + 15)
                                .font(.footnote)
                        } else if aux == 1 {
                            Text("(\(1), \(1))")
                                .position(x: point.x + 20, y: point.y + 15)
                                .font(.footnote)
                        } else {
                            Text("(\(2), \(4))")
                                .position(x: point.x + 20, y: point.y + 15)
                                .font(.footnote)
                        }
                    }
                    
                }
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
        let lmax = width * 0.8
        let delta =  width
        
        var points = [CGPoint]()
        for t in stride(from: lmin, to: lmax, by: precision) {
            
            var (x, y) = (t, 1.5 * t*t / width )
            
            x = max(min(x,delta),-delta)
            y = max(min(y,delta),-delta)
            
            points.append(fromCenter(x: x, y: y, center: center))
        }
        
        return points
    }
}
