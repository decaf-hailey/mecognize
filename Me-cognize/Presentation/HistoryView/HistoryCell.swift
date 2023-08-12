//
//  HistoryCell.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/09.
//

import Foundation
import UIKit

class HistoryCell: MeTableViewCell {
    
    @IBOutlet weak var titleLabel: MeLightLabel!
    
    func config(_ data: History){
        titleLabel.text = Util.DateConverter.getDateString(.weekdayMMM, date: data.date)
        
    }
}
