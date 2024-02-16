//
//  Extensions-Functions.swift
//  GeometryArt
//
//  Created by Gabriel Leite on 26/01/24.
//

import Foundation
import LaTeXSwiftUI
import SwiftUI

func fromCenter(x: CGFloat, y: CGFloat, center: CGPoint) -> CGPoint {
    
    let transform = CGAffineTransform
        .identity
        .translatedBy(x: center.x, y: center.y)
        .scaledBy(x: 1, y: -1)
    
    return CGPoint(x: x, y: y).applying(transform)
    
}

func deg2rad(_ degree: CGFloat) -> CGFloat { .pi/180*degree }

func to2Digits (_ n: Double, digits: Int) -> String {
    let formPercent = NumberFormatter()
    formPercent.minimumFractionDigits = 1
    formPercent.maximumFractionDigits = digits
    
    return formPercent.string(from: NSNumber(value: n)) ?? "Nada"
}

func latexText(_ text: String) -> some View {
    if #available(iOS 16.1, *) {
         return Text(text)
            .fontDesign(.serif)
    } else {
        return Text(text)
    }
}
