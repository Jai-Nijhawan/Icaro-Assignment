//
//  Utils.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 13/02/25.
//

import Foundation

final class Utils {
    static func getCurrentFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        return formatter.string(from: Date())
    }
}
