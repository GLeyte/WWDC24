//
//  Curve2View.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Curve2View: View {
    
    @StateObject private var audioPlayer = AudioPlayerManager()
    @StateObject private var pPlayer = AudioPlayerManager()
    @StateObject private var qPlayer = AudioPlayerManager()
    
    @State private var hasSound = true
        
    @Environment(\.colorScheme) var colorScheme
    
    let screenWidth = UIScreen.main.bounds.width*0.9
    let limit:CGFloat = 10
    
    @State private var a : CGFloat = -10
    @State private var b: CGFloat = -0.33
    @State private var n: Double = -2.5
    @State private var p: Int = 32
    @State private var q: Int = 44
    @State private var r: CGFloat = UIScreen.main.bounds.width / 2
    
    @State private var colorInit: Color = Color.example2
    @State private var colorEnd: Color = Color.example3
    
    @State private var showingInfo = false
    
    @State var directionRightA = true
    @State var playA = true
    
    @State var directionRightB = true
    @State var playB = false
    
    @State var directionRightN = true
    @State var playN = false
    
    @State var directionRightP = true
    @State var playP = false
    
    @State var directionRightQ = true
    @State var playQ = false
        
    @StateObject private var timerData = TimerData()
    
    var body: some View {
        VStack(spacing: 24) {
            
            Curve2(a: $a, b: $b, n: $n, p: $p, q: $q, r: $r, precision: .constant(0.01), colorInit: $colorInit, colorEnd: $colorEnd)
            
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
                returnView("n", n, 2)
                returnView("p", CGFloat(p)/10, 0)
                returnView("q", CGFloat(q)/10, 0)
            }
            
            // -10 -0.38 -0.54 -2.45 10 10
            
            VStack(spacing: 16) {
                
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
                    
                    Slider(value: $b, in: -(limit/10)...0)
                        .tint(colorScheme == .dark ? .white : .black)
                    PlayButton(variavel: $playB)
                    
                }
                
                // Change N
                HStack {
                    LaTeX("$n$")
                    
                    Slider(value: $n, in: -(limit/2)...(limit/2))
                        .tint(colorScheme == .dark ? .white : .black)
                    PlayButton(variavel: $playN)
                    
                }
                
                // Change P
                HStack {
                    LaTeX("$p$")
                    
                    Slider(value: Binding<Double>(
                        get: { Double(self.p) },
                        set: { self.p = Int($0) }
                    ), in: 10...(10 * limit), step: 2)
                    .tint(colorScheme == .dark ? .white : .black)
                    PlayButton(variavel: $playP)
                    
                }
                
                // Change Q
                HStack {
                    LaTeX("$q$")
                    Slider(value: Binding<Double>(
                        get: { Double(self.q) },
                        set: { self.q = Int($0) }
                    ), in: 10...(10 * limit), step: 2)
                    .tint(colorScheme == .dark ? .white : .black)
                    PlayButton(variavel: $playQ)
                    
                }
            }
            
            
        }
        .toolbar {
            ToolbarItem {
                HStack{
                    
                    Button {
                        hasSound.toggle()
                        if !hasSound {
                            if audioPlayer.isPlaying {
                                audioPlayer.stopSound()
                            }
                            if pPlayer.isPlaying  {
                                pPlayer.stopSound()
                            }
                            if qPlayer.isPlaying {
                                qPlayer.stopSound()
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
                        Curve2Info()
                            .presentationDetents([.medium])
                    })
                }
                
            }
        
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            b = -0.33
            r = abs(screenWidth / (2.5 * b) / 3)
        }
        .onChange(of: playA) { newValue in
            audioPlayer.stopSound()
        }
        .onChange(of: playB) { newValue in
            audioPlayer.stopSound()
        }
        .onChange(of: playN) { newValue in
            audioPlayer.stopSound()
        }
        .onReceive(timerData.timer) { _ in
            
            if hasSound && !audioPlayer.isPlaying {
                if playA && playB && playN {
                    audioPlayer.playSound(sound: .ABN, type: "mp3")
                } else if (playA && playB) || (playA && playN) || (playN && playB) {
                    audioPlayer.playSound(sound: .Double, type: "mp3")
                } else if playA {
                    audioPlayer.playSound(sound: .A, type: "mp3")
                } else if playB {
                    audioPlayer.playSound(sound: .B, type: "mp3")
                } else if playN {
                    audioPlayer.playSound(sound: .N, type: "mp3")
                }
            }
            
            if playA {
                
                if directionRightA {
                    a += 0.01
                    if a > limit {
                        directionRightA = false
                    }
                } else {
                    a -= 0.01
                    if a <= -limit {
                        directionRightA = true
                    }
                }
            }
            
            if b <= -1 * limit / 40 {
                r = abs(screenWidth / (2.5 * b) / 3)
            } else if b >= -0.11 && b < -0.07 {
                r = screenWidth / ((abs(b + 0.235))) / 15
            }
            
            if playB {
                
                if directionRightB {
                    b += 0.001
                    if b > 0 {
                        directionRightB = false
                    }
                } else {
                    b -= 0.001
                    if b <= -limit / 10 {
                        directionRightB = true
                    }
                }
            }
            
            if playN {
                
                if directionRightN {
                    n += 0.001
                    if n > limit/2 {
                        directionRightN = false
                    }
                } else {
                    n -= 0.001
                    if n <= -limit/2 {
                        directionRightN = true
                    }
                }
            }
            
            if playP {
                
                if directionRightP {
                    p += 2
                    if p > 10 * Int(limit) {
                        directionRightP = false
                    }
                } else {
                    p -= 2
                    if p <= 10 {
                        directionRightP = true
                        if hasSound {
                            pPlayer.playSound(sound: .HeartBeat, type: "mp3")
                        }
                    }
                }
            }
            
            if playQ {
                
                if directionRightQ {
                    q += 2
                    if q > 10 * Int(limit) {
                        directionRightQ = false
                    }
                } else {
                    q -= 2
                    if q <= 10 {
                        directionRightQ = true
                        if hasSound {
                            qPlayer.playSound(sound: .HeartBeat, type: "mp3")
                        }
                    }
                }
            }
        }
        .onDisappear {
            audioPlayer.stopSound()
            pPlayer.stopSound()
            qPlayer.stopSound()
        }
    }
    
    
    func returnView (_ string: String, _ valor: CGFloat, _ digits: Int) -> some View {
        
        let value = "\(to2Digits(valor, digits:digits))"
        
        return HStack(spacing: 3) {
            
            LaTeX("$\(string) =$")
                .font(.subheadline)
            
            Text(value)
                .font(.subheadline)
        }
    }
}

struct Curve2Info: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            
            LaTeX("\\text{Equations: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack {
                
                LaTeX("$x(t) = r \\cdot (2.5b + cos(n \\cdot (t-b))^p) \\cdot cos(t+a)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
                LaTeX("$y(t) = r \\cdot (2.5 b + sin(n \\cdot (t-b))^q) \\cdot sin(t+a)$")
                    .parsingMode(.onlyEquations)
                    .font(.subheadline)
                
            }
            
            VStack {
                
                LaTeX("r=-1/(7.5 \\cdot b) \\: \\text{    para todo } \\: b \\leq -0.25 ")
                    .parsingMode(.all)
                    .font(.subheadline)
                
                LaTeX("r=8/15 \\: \\: \\: \\text{    para todo } \\: b \\gt -0.25 ")
                    .parsingMode(.all)
                    .font(.subheadline)
            }
            
            LaTeX("\\text{Variables: }")
                .parsingMode(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                
                LaTeX("r \\longrightarrow \\text{Direct relationship with the } \\textbf{value of x and y}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("a \\longrightarrow \\text{Makes the curve } \\textbf{move in time}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("b \\longrightarrow \\text{Changes the } \\textbf{shape of the curve}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("n \\longrightarrow \\text{Influences the } \\textbf{number of curve segments}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("p \\longrightarrow \\text{Generates a } \\textbf{pulse on the x-axis}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                LaTeX("q \\longrightarrow \\text{Generates a } \\textbf{pulse on the y-axis}")
                    .parsingMode(.all)
                    .font(.footnote)
                
                
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
}

#Preview {
    Curve2View()
}
