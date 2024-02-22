//
//  Onboarding1.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 05/02/24.
//

import SwiftUI
import LaTeXSwiftUI

struct Onboarding1: View {
    
    @Environment(\.colorScheme) var colorScheme
    let accentColor = Color(red: 57/255, green: 255/255, blue: 20/255)
    
    var body: some View {
        
        VStack(alignment: .leading, spacing:32) {
            
            VStack {
                latexText("Welcome!")
                latexText("This is ParametricArt")
            }
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity)
            
            onboardingTopic(icon: "person", title: "Author", text: "This application was designed and developed by Gabriel Leite.")
            
            onboardingTopic(icon: "text.book.closed", title: "Learn", text: "Firstly, the concepts of parametric equations are presented, since all the algorithmic art will be generated from this type of equation. Next, each generative artwork is briefly explained.")
            
            onboardingTopic(icon: "play", title: "Play", text: "Each generative artwork has different equations, which allow for countless combinations of parameters, generating fun curves and animations. Play all you want!")
            
            Spacer()
            
            NavigationLink(value: Views.onboarding2) {
                
                latexText("Let's explore!")
                    .padding()
                    .foregroundStyle(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(accentColor)
                    }
                    .frame(maxWidth: .infinity)
                
            }
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
    func onboardingTopic(icon: String, title: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(accentColor)
                .frame(maxWidth: 36)
            
            VStack(alignment: .leading) {
                latexText(title)
                    .font(.title3)
                    .bold()
                
                latexText(text)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    Onboarding1()
}
