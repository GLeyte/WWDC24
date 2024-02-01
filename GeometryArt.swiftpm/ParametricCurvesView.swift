//
//  ParametricCurvesView.swift
//  GenerativeArt
//
//  Created by Gabriel Leite on 22/01/24.
//

import SwiftUI

struct ParametricCurvesView: View {
    
    var body: some View {
        
        VStack {
            
            NavigationLink(value: Views.curve1) {
                Text("Curva 1")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
            }
            
            NavigationLink(value: Views.curve2) {
                Text("Curva 2")
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
           
    }
    
}
