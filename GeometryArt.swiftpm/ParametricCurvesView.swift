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
    
    @State var selectedPage = 0
    
    var body: some View {
        
        VStack(spacing:32) {
            
            latexText("Choose your curve!")
                .font(.title)
                .bold()
            
            // ALL TOGETHER
            
            GeometryReader { geometry in
                
                let width = geometry.size.width
                
                ScrollView {
                    
                        VStack {
                            
                            Button {
                                stackPath.path.append(Views.curve1)
                                animation = false
                            } label: {
                                CardView(curve: .curve1, hasAnimation: $animation)
                                    .frame(height: width * 0.7)
                                    .padding()
                            }
                            
                            Button {
                                stackPath.path.append(Views.curve2)
                                animation = false
                            } label: {
                                CardView(curve: .curve2, hasAnimation: $animation)
                                    .frame(height: width * 0.7)
                                    .padding()
                            }
                            
                            Button {
                                stackPath.path.append(Views.curve3)
                                animation = false
                            } label: {
                                CardView(curve: .curve3, hasAnimation: $animation)
                                    .frame(height: width * 0.7)
                                    .padding()
                            }
                            
                        }
                    }
            }
                
                        
//            Spacer()
//            Spacer()
//            
//            // TABVIEW
//            TabView(selection: $selectedPage) {
//                Button {
//                    stackPath.path.append(Views.curve1)
//                    animation = false
//                } label: {
//                    CardView(curve: .curve1, hasAnimation: $animation)
//                        .padding()
//                }.tag(0)
//                
//                Button {
//                    stackPath.path.append(Views.curve2)
//                    animation = false
//                } label: {
//                    CardView(curve: .curve2, hasAnimation: $animation)
//                        .padding()
//                }.tag(1)
//                
//                Button {
//                    stackPath.path.append(Views.curve3)
//                    animation = false
//                } label: {
//                    CardView(curve: .curve3, hasAnimation: $animation)
//                        .padding()
//                }.tag(2)
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//            
            
        }
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
