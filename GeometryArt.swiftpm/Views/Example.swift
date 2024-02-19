//
//  Example.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 07/02/24.
//

import SwiftUI
import LaTeXSwiftUI


struct Example: View {
    
    @State var animation = false
    @EnvironmentObject private var stackPath: PathType
        
    var body: some View {
        
        
        VStack(alignment: .leading, spacing:32) {
            
            VStack {
                latexText("Parametric Equations in action")
                    .multilineTextAlignment(.center)
            }
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing:16){
                
                latexText("The equation of a circle is shown in the twos ways:")
                    .frame(height: 60)
                
                HStack {
                    
                    latexText("Rectangular equation:")
                    
                    LaTeX("x^2 + y^2 = r^2")
                        .parsingMode(.all)
                    
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.example2, lineWidth: 2)
                )
                
                
                HStack {
                    
                    VStack(spacing:8) {
                        
                        latexText("Paramatetric equations:")
                        
                        LaTeX("0 \\leq t \\leq \\alpha")
                            .parsingMode(.all)
                    }
                    
                    latexText("{")
                        .font(.system(size: 50))
                    
                    VStack {
                        
                        LaTeX("x = r \\cdot cos(t)")
                            .parsingMode(.all)
                        
                        LaTeX("y = r \\cdot sin(t)")
                            .parsingMode(.all)
                        
                    }
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.example3, lineWidth: 2)
                )
            }
            
            CircleExample(t: 60, playT: $animation)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            Button {
                stackPath.path.append(Views.parametrics)
                animation = false
            } label: {
                latexText("Now it's time to play!")
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
    Example()
}

struct CircleExample: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var t: CGFloat
    
    @State var directionRightT = true
    @Binding var playT:Bool
    
    @StateObject private var timerData = TimerData()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                let width = min(geometry.size.width, geometry.size.height)
                
                let r = width/2
                let center = CGPoint(x:width/2, y:width/2)
                
                // Eixos
                Path {path in
                    path.move(to: fromCenter(x: -(r + 10), y: 0, center: center))
                    path.addLine(to: fromCenter(x: (r + 10), y: 0, center: center))
                    path.move(to: fromCenter(x: 0, y: -(r + 10), center: center))
                    path.addLine(to: fromCenter(x: 0, y: (r + 10), center: center))
                }
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 2)
                
                //Circle
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(Color.example2)
                    .frame(width: width, height: width)
                
                // Angulo
                Path { path in
                    path.addArc(center: center, radius: r/6, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(-t)), clockwise: true)
                }
                .stroke(Color.example1, lineWidth: 2)
                
                // Angulo
                Path { path in
                    path.addArc(center: center, radius: r, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(-t)), clockwise: true)
                }
                .stroke(Color.example3, lineWidth: 2)
                
                // Raio
                Path { path in
                    path.move(to: center)
                    path.addLine(to: xyPosition(angulo: t, r: r, center: center))
                }
                .stroke(Color.example3, lineWidth: 2)
                
                Circle()
                    .fill(Color.example3)
                    .frame(width: 8, height: 8)
                    .position(xyPosition(angulo: t, r: r, center: center))
                
                PlayButton(variavel: $playT)
                    .font(.title2)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .position(CGPoint(x: width, y: 0))
                
                LaTeX("$\\alpha = $ \( Int(t))$^{\\circ}$")
                    .id(t)
                    .position(CGPoint(x: center.x + 55, y: center.y - 30))
                
            } // ZStack
        } // GeometryReader
        .aspectRatio(1, contentMode: .fit)
        .onReceive(timerData.timer, perform: { _ in
            
            if playT {
                
                if directionRightT {
                    t += 1
                    if t > 360 {
                        directionRightT = false
                    }
                } else {
                    t -= 1
                    if t <= 0 {
                        directionRightT = true
                    }
                }
            }
        })
    }
    
    func xyPosition(angulo: CGFloat, r: CGFloat, center: CGPoint) -> CGPoint {
        fromCenter(
            x: r * cos(deg2rad(t)),
            y: r * sin(deg2rad(t)),
            center: center
        )
    }
}
