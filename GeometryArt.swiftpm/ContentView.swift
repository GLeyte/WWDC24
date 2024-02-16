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
            case .onboarding2:
                Onboarding2()
            case .onboarding3:
                Onboarding3()
            case .example:
                Example()
            case .curve3:
                Curve3View()
            case .curve3info:
                Curve3Info()
            }
        }
        
    }
}
