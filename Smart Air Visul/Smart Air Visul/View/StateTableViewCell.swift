//
//  StateTableViewCell.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 27/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    
    var state: String? {
        get { return stateLabel.text }
        set { stateLabel.text = newValue } }
    
    @IBOutlet private var stateLabel: UILabel!
    
}
