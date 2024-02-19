//
//  ContentView.swift
//  GenerativeArt
//
//  Created by Gabriel Leite on 25/01/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Onboarding1()
        .ignoresSafeArea()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(for: Views.self) { value in
            switch value {
            case .onboarding2:
                Onboarding2()
            case .onboarding3:
                Onboarding3()
            case .example:
                Example()
            case .parametrics:
                ParametricCurvesView()
            case .curve1:
                Curve1View()
            case .curve2:
                Curve2View()
            case .curve3:
                Curve3View()
            case .curve4:
                Curve4View()
            }
        }
        
    }
}
