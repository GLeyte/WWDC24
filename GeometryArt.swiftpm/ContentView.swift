//
//  ContentView.swift
//  GenerativeArt
//
//  Created by Gabriel Leite on 25/01/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            NavigationLink(value: Views.parametrics) {
                Text("Parametrics")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
            }
            
            NavigationLink(value: Views.forms) {
                
                Text("Forms")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .navigationDestination(for: Views.self) { value in
            switch value {
            case .forms:
                FormsView()
            case .parametrics:
                ParametricCurvesView()
            case .curve1:
                Curve1View()
            case .curve1info:
                Curve1Info()
            case .curve2:
                Curve2View()
            case .curve2info:
                Curve2Info()
            case .circle:
                CircleView()
            case .triangle:
                TriangleView()
            }
        }
        
    }
}
