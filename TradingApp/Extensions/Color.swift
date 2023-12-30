//
//  Color.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let appTheme = ColorTheme()
}

struct ColorTheme {
    let green = Color("green1Color")
    let red = Color("red1Color")
    let background = Color("backgroundColor")
    let gray = Color("gray1Color")
    let gray2 = Color("gray2Color")
    let gray3 = Color("gray3Color")
    let gray4 = Color("gray4Color")
    let gray5 = Color("gray5Color")
    let fieldBackground = Color("fieldBackgroundColor")
}

extension Color {
  var uiColor: UIColor? {
      return UIColor(self)
  }
}
