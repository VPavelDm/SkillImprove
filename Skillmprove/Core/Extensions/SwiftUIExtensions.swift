//
//  SwiftUIExtensions.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import SwiftUI

extension Color {
    var hex: String {
        UIColor(self).hex
    }
    
    init(hex: String) {
        let uiColor = UIColor(hex: hex)
        self.init(uiColor)
    }
}
