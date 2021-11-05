//
//  ViewController.swift
//  Covid Update
//
//  Created by Tina Ho on 10/16/21.
//

import UIKit
import SafariServices //Web View

class CovidViewController: UIViewController {

    @IBOutlet weak var stateAbbrev: UILabel!
    @IBOutlet weak var infectionPct: UILabel!
    @IBOutlet weak var vaccinatedPct: UILabel!
    @IBOutlet weak var icuPct: UILabel!
    @IBOutlet weak var transmissionLevelIcon: UIImageView!
    @IBOutlet weak var MoreInfoButton: UIButton!
    @IBOutlet weak var statePicker: UIPickerView!
    
    var covidManager = CovidManager()
    
    let stateArray = ["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
    var stateUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePicker.delegate = self
        statePicker.dataSource = self

        covidManager.delegate = self
    }
    
    //Triggers Web View
    @IBAction func moreInfoPressed(_ sender: UIButton) {
        if let stateUrl = URL(string: stateUrlString) {
            let vc = SFSafariViewController(url: stateUrl)
            present(vc, animated: true)
        }
        sender.alpha = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Brings sender's opacity back up to fully opaque
            sender.alpha = 1.0
        }
    }
    
}


//MARK: - Picker View
extension CovidViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        covidManager.getCovidData(for: stateArray[row])
        //print(stateArray[row])
    }
    
}

//MARK: - CovidManagerDelegate
extension CovidViewController: CovidManagerDelegate {
    
    func didUpdateWithCovid(_ covidManager: CovidManager, covidData: CovidModel) {
        DispatchQueue.main.async {
            self.stateAbbrev.text = covidData.state
            self.infectionPct.text = covidData.infectionRateString
            self.vaccinatedPct.text = covidData.vaccinationsCompletedRatioString
            self.icuPct.text = covidData.icuCapacityRatioString
            self.transmissionLevelIcon.image = UIImage(systemName: "\(covidData.cdcTransmissionLevel).circle.fill")
            self.view.backgroundColor = covidData.cdcTransmissionLevelColor
            self.MoreInfoButton.tintColor = covidData.cdcTransmissionLevelColor
            self.stateUrlString = "https://covidactnow.org/us/\(covidData.state)"
        }
    }
    
    func didFailWithError(_ covidManager: CovidManager, error: Error) {
        print(error)
    }
    
}



