//
//  PathType.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import Foundation

class PathType: ObservableObject {
    @Published var path: [Views]
    init(){
        self.path = []
    }
}

enum Views {
    case parametrics, curve1, curve1info, curve2, curve2info, curve3, curve3info
    case onboarding2, onboarding3, example
}
