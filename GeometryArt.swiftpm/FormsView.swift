//
//  FormsView.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import SwiftUI

struct FormsView: View {
    
    var body: some View {
        
        VStack {
            
            NavigationLink(value: Views.triangle) {
                Text("Triangulo")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
            }
            
            NavigationLink(value: Views.circle) {
                Text("Circulo")
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
