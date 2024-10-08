//
//  Tracker.swift
//  Tracker
//
//  Created by Глеб Хамин on 30.07.2024.
//

import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [DayOfWeek]
    let isPinned: Bool
}

enum DayOfWeek: String, Codable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

