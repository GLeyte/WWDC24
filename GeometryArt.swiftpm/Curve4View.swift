//
//  Curve4View.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 17/02/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Curve4View: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let screenWidth = UIScreen.main.bounds.width*0.9
    let limit = 10.0
    
    @State private var a : CGFloat = 5.1
    @State private var b: CGFloat = 1
    @State private var alpha: CGFloat = 1
    @State private var beta: CGFloat = 1
    @State var velocidade:CGFloat = 1.0
    
    @State private var colorInit: Color = Color.example2
    @State private var colorEnd: Color = Color.example3
    
    @State private var showCircle = false
    @State private var showEnd = false
    
    @State private var showingInfo = false
    
    @State var directionRightA = true
    @State var playA = false
    
    @State var directionRightB = true
    @State var playB = true
    
    @State var directionRightALPHA = true
    @State var playALPHA = false
    
    @State var directionRightBETA = true
    @State var playBETA = false
        
    @StateObject private var timerData = TimerData()
    
    var body: some View {
        VStack(spacing: 16) {
            
            ZStack {
                
                Curve4(a: $a, b: $b, alpha: $alpha, beta: $beta, precision: .constant(0.01), colorInit: $colorInit, colorEnd: $colorEnd, showCircle: $showCircle, showEnd: $showEnd)
                
                HStack{
                    
                    PlayButton(variavel: $showCircle)
                    
                    Spacer()
                    
                    PlayButton(variavel: $showEnd)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }
            
            HStack {
                returnView("a", a, 1)
                returnView("b", b, 1)
                returnView("\\alpha", alpha, 2)
                returnView("\\beta", beta, 2)
            }
            
            // Change A
            HStack {
                LaTeX("$a$")
                                
                Slider(value: $a, in: -limit...limit)
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playA)

            }
            
            // Change B
            HStack {
                LaTeX("$b$")
                   
                Slider(value: $b, in: -limit...limit)
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playB)
                
            }
            
            // Change alpha
            HStack {
                LaTeX("$\\alpha$")
                   
                Slider(value: $alpha, in: (-limit/10)...(limit/10))
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playALPHA)
                
            }
            
            // Change h
            HStack {
                LaTeX("$\\beta$")
                   
                Slider(value: $beta, in: (-limit/10)...(limit/10))
                    .tint(colorScheme == .dark ? .white : .black)
                
                PlayButton(variavel: $playBETA)
                
            }
            
            HStack {
                LaTeX("\\text{Center color:}")
                    .parsingMode(.all)
                ColorPicker("", selection: $colorInit)
                    .labelsHidden()
            }
            
            HStack {
                LaTeX("\\text{Side color:}")
                    .parsingMode(.all)
                ColorPicker("", selection: $colorEnd)
                    .labelsHidden()
            }
            
            // Change Velocidade
            HStack {
                LaTeX("$\\text{Speed}$")
                                
                Slider(value: $velocidade, in: 0.25...1)
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
                    Curve4Info()
                        .presentationDetents([.medium])
                })

            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onReceive(timerData.timer) { _ in
            
            if playA {
                
                if directionRightA {
                    a += 0.01 * velocidade
                    if a > limit {
                        directionRightA = false
                    }
                } else {
                    a -= 0.01 * velocidade
                    if a <= -limit {
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
                    if b <= -limit {
                        directionRightB = true
                    }
                }
            }
            
            if playALPHA {

                if directionRightALPHA {
                    alpha += 0.001 * velocidade
                    if alpha > limit/10 {
                        directionRightALPHA = false
                    }
                } else {
                    alpha -= 0.001 * velocidade
                    if alpha <= -limit/10 {
                        directionRightALPHA = true
                    }
                }
            }
            
            if playBETA {

                if directionRightBETA {
                    beta += 0.001 * velocidade
                    if beta > limit/10 {
                        directionRightBETA = false
                    }
                } else {
                    beta -= 0.001 * velocidade
                    if beta <= -limit/10 {
                        directionRightBETA = true
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

struct Curve4Info: View {
    
    var body: some View {
        VStack(spacing: 16) {
            
            LaTeX("\\text{Equations: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack {
                
                LaTeX("$x(t) = sin(\\alpha \\cdot a\\cdot t +b)\\cdot cos(t+b)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
                LaTeX("$y(t) = sin(t+b)\\cdot cos(\\beta \\cdot a\\cdot t + b)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
            }
            
            LaTeX("\\text{Variables: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                
                LaTeX("a \\longrightarrow \\text{Influences the } \\textbf{number of curve segments}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("b \\: \\longrightarrow \\text{Makes a } \\textbf{tridimensional rotation}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("\\alpha \\longrightarrow \\text{Makes a } \\textbf{horizontal rotation}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("\\beta \\longrightarrow \\text{Makes a } \\textbf{vertical rotation}")
                    .parsingMode(.all)
                    .font(.footnote)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
