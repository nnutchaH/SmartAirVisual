//
//  CitiesTableViewCell.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 2/1/2563 BE.
//  Copyright © 2563 Nutnutcha Hanggitthagul. All rights reserved.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
    
    var cities: String? {
        get { return citiesLabel.text }
        set { citiesLabel.text = newValue } }
    
    @IBOutlet private var citiesLabel: UILabel!
    
}
