//
//  Onboarding3.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 07/02/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Onboarding3: View {
        
    var body: some View {
        
        VStack(alignment: .leading, spacing:32) {
            
            VStack {
                latexText("What about Parametric equations?")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing:16){
                
                latexText("This is the type of equation we are first introduced to, y = f(x). Using the values of x and y we have the points (x, y), and can create various shapes. However, some shapes are difficult, or even impossible, to sketch in this way.")
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Rectangle().foregroundStyle(.clear).frame(height: 5)
                
                HStack(spacing:8) {
                    VStack {
                        latexText("Choose")
                        LaTeX("t")
                            .parsingMode(.all)
                    }
                    
                    LaTeX("\\rightarrow")
                        .parsingMode(.all)
                    
                    VStack(spacing: 24) {
                        
                        VStack {
                            latexText("Find x using f")
                                .multilineTextAlignment(.center)
                            LaTeX("x = f(t)")
                                .parsingMode(.all)
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        
                        VStack {
                            latexText("Find y using g")
                                .multilineTextAlignment(.center)
                            LaTeX("y=g(t) ")
                                .parsingMode(.all)
                        }
                        .fixedSize(horizontal: true, vertical: false)
                    }
                    
                    LaTeX("\\rightarrow")
                        .parsingMode(.all)
                    
                    VStack {
                        latexText("Plot point")
                        LaTeX("(x,y)")
                            .parsingMode(.all)
                    }
                }
                .padding(.vertical, 8)
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
                    
                    LaTeX("t=\\dfrac{\\pi}{2}")
                        .parsingMode(.all)
                    
                    LaTeX("\\longrightarrow")
                        .parsingMode(.all)
                    
                    VStack(spacing: 24) {
                        
                        LaTeX("x = cos(t) = 0")
                            .parsingMode(.all)
                        
                        LaTeX("y = sin(t) = 1")
                            .parsingMode(.all)
                    }
                    
                    LaTeX("\\longrightarrow")
                        .parsingMode(.all)
                    
                    LaTeX("(0,1)")
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
            
            NavigationLink(value: Views.example) {
                
                latexText("Let's go to a visual example")
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
    Onboarding3()
}
