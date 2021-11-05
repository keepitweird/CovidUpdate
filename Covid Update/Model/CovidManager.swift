//
//  CovidManager.swift
//  Covid Update
//
//  Created by Tina Ho on 10/16/21.
//

import Foundation

protocol CovidManagerDelegate {
    func didUpdateWithCovid(_ covidManager: CovidManager, covidData: CovidModel)
    func didFailWithError(_ covidManager: CovidManager, error: Error)
}


struct CovidManager {
    
    var delegate: CovidManagerDelegate?
    
    //URL Format: "https://api.covidactnow.org/v2/state/{state}.json?apiKey={apiKey}"
    let baseURL = "https://api.covidactnow.org/v2/state"
    
    let apiKey = "<YOUR_API_KEY>" //Please enter your API Key here
    
    func getCovidData(for state: String) {
        let urlString = "\(baseURL)/\(state).json?apiKey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let covid = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWithCovid(self, covidData: covid)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ covidData: Data) -> CovidModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            
            let state = decodedData.state
            let cdcTransmissionLevel = decodedData.cdcTransmissionLevel
            let infectionRate = decodedData.metrics.infectionRate
            let icuCapacityRatio = decodedData.metrics.icuCapacityRatio
            let vaccinationsCompletedRatio = decodedData.metrics.vaccinationsCompletedRatio
            
            let covid = CovidModel(state: state, cdcTransmissionLevel: cdcTransmissionLevel, infectionRate: infectionRate, icuCapacityRatio: icuCapacityRatio, vaccinationsCompletedRatio: vaccinationsCompletedRatio)
            
            return covid
        } catch {
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
    
}
