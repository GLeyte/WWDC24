//
//  Curve1View.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Curve1View: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let screenWidth = UIScreen.main.bounds.width*0.9
    let limit:CGFloat = 10
    
    @State private var a : CGFloat = 0
    @State private var b: CGFloat = -0.25
    @State private var velocidade: CGFloat = 1
    
    @State private var colorInit: Color = Color.example2
    @State private var colorEnd: Color = Color.example3
    
    @State private var showingInfo = false
    
    @State var directionRightA = true
    @State var playA = true
    
    @State var directionRightB = true
    @State var playB = false
    
    @StateObject private var timerData = TimerData()
    
    var body: some View {
        VStack(spacing: 16) {
            
            Curve1(a: $a, b: $b, colorInit: $colorInit, colorEnd: $colorEnd, precision: .constant(0.01))
            
            HStack {
                returnView("a", a, 2)
                returnView("b", b, 1)
            }
            
            // Change A
            HStack {
                LaTeX("$a$")
                                
                Slider(value: $a, in: 0...limit)
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playA)

            }
            
            // Change B
            HStack {
                LaTeX("$b$")
                   
                Slider(value: $b, in: 0...limit)
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playB)
                
            }
            
            HStack {
                LaTeX("\\text{Top color:}")
                    .parsingMode(.all)
                ColorPicker("", selection: $colorInit)
                    .labelsHidden()
            }
            
            HStack {
                LaTeX("\\text{Bottom color:}")
                    .parsingMode(.all)
                ColorPicker("", selection: $colorEnd)
                    .labelsHidden()
            }
            
            // Change Velocidade
            VStack {
                LaTeX("$\\text{Speed}$")
                                
                Slider(value: $velocidade, in: 0.25...3)
                    .tint(colorScheme == .dark ? .white : .black)
            }
            
        }
        .toolbar {
            ToolbarItem {
                
                Button {
                    showingInfo.toggle()
                } label: {
                    Image(systemName: "info.circle.fill")
                }
                .sheet(isPresented: $showingInfo, content: {
                    Curve1Info()
                        .presentationDetents([.medium])
                })

            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onReceive(timerData.timer) { _ in
            
            if playA {
                
                if directionRightA {
                    a += 0.001 * velocidade
                    if a > limit {
                        directionRightA = false
                    }
                } else {
                    a -= 0.001 * velocidade
                    if a <= 0 {
                        directionRightA = true
                    }
                }
            }
            
            
            if playB {

                if directionRightB {
                    b += 0.01 * velocidade
                    if b > limit {
                        directionRightB = false
                    }
                } else {
                    b -= 0.01 * velocidade
                    if b <= 0 {
                        directionRightB = true
                    }
                }
            }
            
        }
    }
    
    func returnView (_ string: String, _ valor: CGFloat, _ digits: Int) -> some View {

        let value = "\(to2Digits(valor, digits:digits))"

        return HStack(spacing: 6) {
            
            LaTeX("$\(string) =$")
                .font(.subheadline)
            
            Text(value)
                .font(.subheadline)
        }
    }
}

struct Curve1Info: View {
    
    var body: some View {
        VStack(spacing: 16) {
            
            LaTeX("\\text{Equations: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack {
                
                LaTeX("$x(t) = r \\cdot sin(at + b)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
                LaTeX("$y(t) = r \\cdot sin(t)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
            }
            
            LaTeX("\\text{Variables: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                
                LaTeX("r \\longrightarrow \\text{Direct relationship with the } \\textbf{value of x and y}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("a \\longrightarrow \\text{Changes the } \\textbf{shape of the curve}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("b \\longrightarrow \\text{Makes the curve } \\textbf{move in time}")
                    .parsingMode(.all)
                    .font(.footnote)
            
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
