//
//  HistoryViewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/01.
//

import Foundation
import UIKit


class HistoryViewController : UITableViewController {
    
    var historyList : [History]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHistories()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistories()
    }
    
    private func getHistories(){
        historyList = LocalData.loadHistory()
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HistoryCell = self.tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseIdentifier, for: indexPath) as! HistoryCell
        guard let each = historyList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.config(each)
                
        return cell
    }
    

}

