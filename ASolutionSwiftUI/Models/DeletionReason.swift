//
//  DeletionReason.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation

enum DeletionReason: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case lostCard = "Lost Card"
    case stolenCard = "Stolen Card"
    case damagedCard = "Damaged Card"
    case noLongerNeeded = "No Longer Needed"
    case other = "Other"

    var description: String {
        return self.rawValue
    }
}