//
//  Curva3View.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 08/02/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Curve3View: View {
    
    @StateObject private var audioPlayer = AudioPlayerManager()
    
    @State private var hasSound = true
    
    @Environment(\.colorScheme) var colorScheme
    
    let screenWidth = UIScreen.main.bounds.width*0.9
    let limit = 2.0
    
    @State private var a : CGFloat = 30
    @State private var b: CGFloat = 0
    @State private var w: CGFloat = 1
    @State private var h: CGFloat = 2
    
    @State private var colorInit: Color = Color.example2
    @State private var colorEnd: Color = Color.example3
    
    @State private var showingInfo = false
    
    @State var directionRightA = true
    @State var playA = false
    
    @State var directionRightB = true
    @State var playB = false
    
    @State var directionRightW = true
    @State var playW = true
    
    @State var directionRightH = true
    @State var playH = false
    
    @StateObject private var timerData = TimerData()
    
    var body: some View {
        VStack(spacing: 24) {
            
            
            Curve3(a: $a, b: $b, l: $w, h: $h, precision: .constant(0.005), colorInit: $colorInit, colorEnd: $colorEnd)
            
            HStack(spacing:16) {
                
                ColorPicker("Side color", selection: $colorEnd, supportsOpacity: true)
                    .labelsHidden()
                ColorPicker("Center color", selection: $colorInit, supportsOpacity: true)
                    .labelsHidden()
                
            }
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            HStack {
                returnView("a", a, 1)
                returnView("b", b, 2)
                returnView("w", w, 1)
                returnView("h", h, 1)
            }
            
            VStack(spacing: 16) {
                
                // Change A
                HStack {
                    LaTeX("$a$")
                    
                    Slider(value: $a, in: 0...(30))
                        .tint(colorScheme == .dark ? .white : .black)
                    
                    PlayButton(variavel: $playA)
                    
                }
                
                // Change B
                HStack {
                    LaTeX("$b$")
                    
                    Slider(value: $b, in: 0...1)
                        .tint(colorScheme == .dark ? .white : .black)
                    
                    PlayButton(variavel: $playB)
                    
                }
                
                // Change w
                HStack {
                    LaTeX("$w$")
                    
                    Slider(value: $w, in: -limit...limit)
                        .tint(colorScheme == .dark ? .white : .black)
                    
                    PlayButton(variavel: $playW)
                    
                }
                
                // Change h
                HStack {
                    LaTeX("$h$")
                    
                    Slider(value: $h, in: -limit...limit)
                        .tint(colorScheme == .dark ? .white : .black)
                    
                    PlayButton(variavel: $playH)
                    
                }
            }
            
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Button {
                        hasSound.toggle()
                        if !hasSound {
                            if audioPlayer.isPlaying {
                                audioPlayer.stopSound()
                            }
                        }
                    } label: {
                        Image(systemName: hasSound ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    }
                    
                    Spacer()
                    
                    Button {
                        showingInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .sheet(isPresented: $showingInfo, content: {
                        Curve3Info()
                            .presentationDetents([.medium])
                    })
                }

            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: playA) { newValue in
            audioPlayer.stopSound()
        }
        .onChange(of: playB) { newValue in
            audioPlayer.stopSound()
        }
        .onChange(of: playW) { newValue in
            audioPlayer.stopSound()
        }
        .onChange(of: playH) { newValue in
            audioPlayer.stopSound()
        }
        .onReceive(timerData.timer) { _ in
            
            if hasSound && !audioPlayer.isPlaying {
                
                if playA && playB && playW && playH {
                    audioPlayer.playSound(sound: .ABN, type: "mp3")
                } else if (playH && playW) || (playB && playW) || (playH && playB) {
                    audioPlayer.playSound(sound: .Epic, type: "mp3")
                } else if playA && playB{
                    audioPlayer.playSound(sound: .Double, type: "mp3")
                } else if playA {
                    audioPlayer.playSound(sound: .A, type: "mp3")
                } else if playB {
                    audioPlayer.playSound(sound: .B, type: "mp3")
                } else if playW {
                    audioPlayer.playSound(sound: .B, type: "mp3")
                } else if playH {
                    audioPlayer.playSound(sound: .B, type: "mp3")
                }
            }
            
            if playA {
                
                if directionRightA {
                    a += 0.04
                    if a > 30 {
                        directionRightA = false
                    }
                } else {
                    a -= 0.04
                    if a <= 0 {
                        directionRightA = true
                    }
                }
            }
            
            
            if playB {
                
                if directionRightB {
                    b += 0.001
                    if b > 1 {
                        directionRightB = false
                    }
                } else {
                    b -= 0.001
                    if b <= 0 {
                        directionRightB = true
                    }
                }
            }
            
            if playW {
                
                if directionRightW {
                    w += 0.01
                    if w > limit {
                        directionRightW = false
                    }
                } else {
                    w -= 0.01
                    if w <= -limit {
                        directionRightW = true
                    }
                }
            }
            
            if playH {
                
                if directionRightH {
                    h += 0.01
                    if h > limit {
                        directionRightH = false
                    }
                } else {
                    h -= 0.01
                    if h <= -limit {
                        directionRightH = true
                    }
                }
            }
            
        }
        .onDisappear {
            audioPlayer.stopSound()
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

struct Curve3Info: View {
    
    var body: some View {
        VStack(spacing: 16) {
            
            LaTeX("\\text{Equations: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack {
                
                LaTeX("$x(t) = w\\cdot cos(t+b) -cos(at)\\cdot sin(t+b)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
                LaTeX("$y(t) = h\\cdot sin(t+b) - sin(a\\cdot(t+b))$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
            }
            
            LaTeX("\\text{Variables: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                
                LaTeX("a \\: \\longrightarrow \\text{Influences the } \\textbf{number of curve segments}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("b\\: \\longrightarrow \\textbf{Rotates the curve}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("w \\longrightarrow \\text{Changes the } \\textbf{curve's width}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("h\\: \\longrightarrow \\text{Changes the } \\textbf{curve's height}")
                    .parsingMode(.all)
                    .font(.footnote)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    Curve3View()
}
