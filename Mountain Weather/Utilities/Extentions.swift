//
//  Extentions.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation
import SwiftUI

 
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

  
struct DeviceRotationViewModifier: ViewModifier {
   let action: (UIDeviceOrientation) -> Void

   func body(content: Content) -> some View {
       content
           .onAppear()
           .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
               action(UIDevice.current.orientation)
           }
   }
}

 extension View {
   func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
       self.modifier(DeviceRotationViewModifier(action: action))
   }
}

extension String{
    func changeCentigradeToFahrenheit() -> String{
        let temp = Double(self)
        return "\(((temp! * 9/5) + 32).roundedDecimal(to: 2))"
    }
}
extension Double {
  func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return result
    }
}
extension String{
    func formatDate()->String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE - h a"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "There was an error decoding the string"
        }
    }
}
