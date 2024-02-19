//
//  PlayButton.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 29/01/24.
//

import SwiftUI

struct PlayButton: View {
    
    @Binding var variavel: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            variavel.toggle()
        } label: {
            Image(systemName: variavel ?  "stop.fill" : "play.fill")
                .tint(colorScheme == .dark ? .white : .black)
        }
    }
}
