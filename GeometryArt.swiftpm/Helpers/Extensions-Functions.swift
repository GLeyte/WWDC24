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

extension Color {
    
    static let accentColor = Color(red: 57/255, green: 255/255, blue: 20/255)
    static let secondary = Color(red: 29/255, green: 29/255, blue: 31/255)
    
    static let example1 = Color(red: 245/255, green: 183/255, blue: 0/255)
    static let example2 = Color(red: 0/255, green: 161/255, blue: 228/255)
    static let example3 = Color(red: 220/255, green: 0/255, blue: 115/255)
    
}
