//
//  Card.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import CoreData
import SwiftUI

extension Card {
    var textColor: Color {
        get { Color(hex: textColor_!) }
        set { textColor_ = newValue.hex }
    }
}
