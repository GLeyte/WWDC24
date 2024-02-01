//
//  TriangleView.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI
import LaTeXSwiftUI

struct TriangleView: View {
    
    let screenWidth = UIScreen.main.bounds.width*0.9
    @State private var divisions : Int = 100
    @State private var k: CGFloat = 25
    
    @State private var colorInit: Color = .cyan
    @State private var colorEnd: Color = .pink
    
    let limit:CGFloat = 100
    
    @StateObject private var timerData = TimerData()
    
    @State var directionRightK = true
    @State var playK = false
    
    var body: some View {
        VStack {
            
            LaTeX("$y = x + k\\: \\text{mod} \\: 2 + k$")
                .parsingMode(.onlyEquations)
                .foregroundStyle(.white)
            
            TriangleForm(valor: $k, division: $divisions,colorInit: $colorInit, colorEnd: $colorEnd)
            
            // Change K
            HStack {
                LaTeX("$k$")
                    .parsingMode(.onlyEquations)
                    .foregroundStyle(.white)
                                
                Slider(value: $k, in: 0...limit)
                    .tint(.white)
                    .frame(maxWidth: screenWidth*0.8)
                
                PlayButton(variavel: $playK)

            }
        
            // Divisions
            HStack {
                
                LaTeX("$n$")
                    .parsingMode(.onlyEquations)
                    .foregroundStyle(.white)
                
                Slider(value: Binding<Double>(
                    get: { Double(self.divisions) },
                    set: { self.divisions = Int($0) }
                ), in: 60...Double(150), step: 10)
                .tint(.white)
                .frame(maxWidth: screenWidth*0.8)

            }
            
            HStack {
                LaTeX("Color in the center:")
                    .foregroundStyle(.white)
                ColorPicker("", selection: $colorInit)
                Spacer()
            }
            
            HStack {
                LaTeX("Color in the sides:")
                    .foregroundStyle(.white)
                ColorPicker("", selection: $colorEnd)
                Spacer()
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.black)
        .onReceive(timerData.timer) { _ in
            
            if playK {
                
                if directionRightK {
                    k += 0.1
                    if k > limit {
                        directionRightK = false
                    }
                } else {
                    k -= 0.1
                    if k <= 0 {
                        directionRightK = true
                    }
                }
            }

        }
    }
    
}
