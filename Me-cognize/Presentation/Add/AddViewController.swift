//
//  AddViewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/09/11.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddDisplayLogic{
    func updateResultData(viewModel: Add.Send.ViewModel)
    func showAlert(viewModel: Add.Alert.ViewModel)
}

class AddViewController: UIViewController, AddDisplayLogic, UITableViewDelegate, UITableViewDataSource {
 
    var interactor: AddBusinessLogic?
    var router: (NSObjectProtocol & AddRoutingLogic & AddDataPassing)?
    
    @IBOutlet var tableView: UITableView!
    
    // send button layout
    @IBOutlet var keyboardBottom: NSLayoutConstraint!
    @IBOutlet var buttonLeft: NSLayoutConstraint!
    @IBOutlet var buttonRight: NSLayoutConstraint!
    @IBOutlet var buttonHeight: NSLayoutConstraint!
    
    var sendingData: String = ""
    var resultData: Sentiment?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preventDoubleTap()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let resultData = resultData else {
            self.showAlert("There are no result to save.\nPlease send your data first.")
            return
        }
        let history = History(magnitude: resultData.magnitude, score: resultData.score, text: sendingData)
        let request = Add.Save.Request(history: history)
        interactor?.saveLocal(request: request)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        Task {
            let document = Document(content: sendingData, language: "en", type: DocumentType.PLAIN_TEXT.rawValue)
            let request = Add.Send.Request(document: document)
            await interactor?.getAnalyze(request: request)
        }
    }
    
    func updateSendingData(_ text : String){
        sendingData = text
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateResultData(viewModel: Add.Send.ViewModel){
        resultData = viewModel.sentiment
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showAlert(viewModel: Add.Alert.ViewModel) {
        self.showAlert(viewModel.message)
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
            cell.config(first: sendingData == "", isSent: resultData != nil)
            cell.textChanged = { [weak self] text in
                self?.updateSendingData(text)
            }
            return cell
            
        default:
            let cell : AddResultCell = self.tableView.dequeueReusableCell(withIdentifier: AddResultCell.reuseIdentifier, for: indexPath) as! AddResultCell
            cell.config(resultData)
            return cell
        }
    }
    
}

extension AddViewController {
    private func setup() {
        let viewController = self
        let interactor = AddInteractor()
        let presenter = AddPresenter()
        let router = AddRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        // for test     
        // let f = UIScreen.main.bounds.size.height - keyboardSize
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let safeareaBottom = Util.UI.getKeyRootView()?.view.safeAreaInsets.bottom ?? 0
        
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }

            self.keyboardBottom.constant = -(keyboardSize) + safeareaBottom
            self.buttonLeft.constant = 0
            self.buttonRight.constant = 0
            self.buttonHeight.constant = 50
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        let info = sender.userInfo!
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }
            
            self.keyboardBottom.constant = 0
            self.buttonLeft.constant = 15
            self.buttonRight.constant = 15
            self.buttonHeight.constant = 35
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
}
