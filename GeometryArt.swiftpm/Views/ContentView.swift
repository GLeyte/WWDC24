//
//  ContentView.swift
//  GenerativeArt
//
//  Created by Gabriel Leite on 25/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isOnboarding") var isOnboarding = true

    
    var body: some View {
        VStack {
            if isOnboarding {
                Onboarding1()
            } else {
                ParametricCurvesView()
            }
        }
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
