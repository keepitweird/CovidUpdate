//
//  CovidModel.swift
//  Covid Update
//
//  Created by Tina Ho on 10/18/21.
//

import Foundation
import UIKit

struct CovidModel {

    let state: String
    let cdcTransmissionLevel: Int
    let infectionRate: Double
    let icuCapacityRatio: Double
    let vaccinationsCompletedRatio: Double
    
    var cdcTransmissionLevelColor: UIColor {
        switch cdcTransmissionLevel {
        case 0:
            return UIColor(red: 0.23, green: 0.89, blue: 0.45, alpha: 1.00)
        case 1:
            return UIColor(red: 1.00, green: 0.95, blue: 0.00, alpha: 1.00)
        case 2:
            return UIColor(red: 1.00, green: 0.62, blue: 0.10, alpha: 1.00)
        case 3:
            return UIColor(red: 1.00, green: 0.30, blue: 0.30, alpha: 1.00)
        case 4:
            return UIColor(red: 1.00, green: 0.22, blue: 0.22, alpha: 1.00)
        default:
            return UIColor(red: 0.44, green: 0.35, blue: 0.89, alpha: 1.00)
        }
    }
    var infectionRateString: String {
        return String(format: "%.0f%%", infectionRate * 100)
    }
    var icuCapacityRatioString: String {
        return String(format: "%.0f%%", icuCapacityRatio * 100)
    }
    var vaccinationsCompletedRatioString: String {
        return String(format: "%.0f%%", vaccinationsCompletedRatio * 100)
    }
    
}
