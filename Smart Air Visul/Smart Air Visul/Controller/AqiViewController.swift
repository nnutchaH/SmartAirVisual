//
//  ViewController.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 4/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//

import UIKit
import Moya

class AqiViewController: UIViewController {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var aqiLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    
    private let network = AirVisualRequest()
    var city: City?
    var state: State?
    private var networkData: DataClass = DataClass(city: "", state: "", country: "", location: Location(type: "", coordinates: [
        0]), current: Current(weather: Weather(ts: "", tp: 0, pr: 0, hu: 0, ws: 0, wd: 0, ic: ""), pollution: Pollution(ts: "", aqius: 0, mainus: "", aqicn: 0, maincn: "")))
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        network.requestCitiData(city: city?.city ?? "", state: state?.state ?? "") { (result) in
            switch result {
            case .success(let data):
                print(data)
                self.networkData = data.data
                self.setupUI()
            case .failure(_):
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network.requestCitiData(city: city?.city ?? "", state: state?.state ?? "") { (result) in
            switch result {
            case .success(let data):
                print(data)
                self.networkData = data.data
                self.setupUI()
            case .failure(_):
                break
            }
        }
    }
    
    private func setupUI() {
        aqiLabel.text = String(networkData.current.pollution.aqius)
        tempLabel.text = String(networkData.current.weather.tp)
        humidityLabel.text = String(networkData.current.weather.hu)
        nameLabel.text = String(networkData.city)
    }
}




