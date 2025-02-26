//
//  AddViewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/01.
//

import UIKit

class AddViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var keyboardBottom: NSLayoutConstraint!
    var sendingData: String = ""
    
    var resultData: Sentiment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preventDoubleTap()
    }
    

    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let f = UIScreen.main.bounds.size.height - keyboardSize
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let safeareaBottom = Util.UI.getKeyRootView()?.view.safeAreaInsets.bottom ?? 0
        
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }
            
            self.keyboardBottom.constant = -(keyboardSize + safeareaBottom)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        let info = sender.userInfo!
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }
            
            self.keyboardBottom.constant = 0
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let resultData = resultData else {
            self.showAlert("There are nothing to save.\nPlease send your data first.")
            return
        }
        let history = History(magnitude: resultData.magnitude, score: resultData.score, text: sendingData)

        LocalData.saveHistory(history) { [weak self] in
            self?.showAlert("Saved!")
        } onFail: { [weak self] in
            self?.showAlert("Error -------- \n \(resultData)")
        }
        
        
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let data = Document(content: sendingData, language: "en", type: DocumentType.PLAIN_TEXT.rawValue)
        NLRequest.analyzeSentiment(document: data) { [weak self] response in
            Util.Print.PrintLight(printType: .checkValue(response))
            self?.resultData = response.documentSentiment
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } failure: { error in
            Util.Print.PrintLight(printType: .responseError(error))
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell : AddTypingCell = tableView.dequeueReusableCell(withIdentifier: AddTypingCell.reuseIdentifier, for: indexPath) as! AddTypingCell
            cell.textChanged = { [weak self] text in
                self?.sendingData = text
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
//                * test code for animation            
//                let bottomOffset = CGPoint(x: 0, y: baseView.height - scrollView.bounds.height + contentView.bottomY)
//                let textViewOffset = CGPoint(x: 0, y: reasonV.frame.origin.y+320)
//                if textViewOffset.y > bottomOffset.y {
//                    scrollView.setContentOffset(bottomOffset, animated: true)
//                } else {
//                    scrollView.setContentOffset(textViewOffset, animated: true)
//                }
            
            
            return cell
        default:
            let cell : AddResultCell = self.tableView.dequeueReusableCell(withIdentifier: AddResultCell.reuseIdentifier, for: indexPath) as! AddResultCell
            
            cell.config(resultData)
            return cell
            
        }
    }
}



