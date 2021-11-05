//
//  CovidData.swift
//  Covid Update
//
//  Created by Tina Ho on 10/18/21.
//

import Foundation

struct CovidData: Decodable {
    let country: String
    let state: String
    let metrics: Metrics
    let cdcTransmissionLevel: Int
}

struct Metrics: Decodable {
    let testPositivityRatio: Double
    let infectionRate: Double
    let icuCapacityRatio: Double
    let vaccinationsCompletedRatio: Double
    
}

