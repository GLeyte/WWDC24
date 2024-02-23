//
//  ParametricCurvesView.swift
//  GenerativeArt
//
//  Created by Gabriel Leite on 22/01/24.
//

import SwiftUI

struct ParametricCurvesView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var stackPath: PathType
    @State private var animation = true
        
    var body: some View {
        
        VStack(spacing:32) {
            
            latexText("Choose your curve!")
                .font(.title)
                .bold()
                        
            GeometryReader { geometry in
                
                let width = geometry.size.width
                
                ScrollView {
                    
                    VStack(spacing:24) {
                        
                        Button {
                            stackPath.path.append(Views.curve4)
                            animation = false
                        } label: {
                            CardView(curve: .curve4, hasAnimation: $animation)
                                .frame(height: width * 0.7)
                        }
                        
                        Button {
                            stackPath.path.append(Views.curve2)
                            animation = false
                        } label: {
                            CardView(curve: .curve2, hasAnimation: $animation)
                                .frame(height: width * 0.7)
                        }
                        
                        Button {
                            stackPath.path.append(Views.curve1)
                            animation = false
                        } label: {
                            CardView(curve: .curve1, hasAnimation: $animation)
                                .frame(height: width * 0.7)
                        }
                        
                        Button {
                            stackPath.path.append(Views.curve3)
                            animation = false
                        } label: {
                            CardView(curve: .curve3, hasAnimation: $animation)
                                .frame(height: width * 0.7)
                        }
                        
                    }
                }
            }
            
            NavigationLink(value: Views.onboarding2) {
                latexText("Review parametric equations")
                    .padding()
                    .foregroundStyle(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            animation = true
        }
        
    }
    
}

#Preview {
    ParametricCurvesView()
}
