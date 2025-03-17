//
//  AddResultCell.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/09.
//

import Foundation
import UIKit

class AddResultCell : MeTableViewCell {
    
    @IBOutlet var label: MeLightLabel!
    
    func config(_ data: Sentiment?){
        guard let data = data else {
            label.text = "Try sending your today!"
            return
        }
        label.text = String(describing: data)
    }
    
}

