//
//  historyviewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/08/29.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HistoryDisplayLogic {
    func displayList(viewModel: HistoryModel.List.ViewModel)
}

class historyviewController: UITableViewController, HistoryDisplayLogic {
    var interactor: HistoryBusinessLogic?
    var router: (NSObjectProtocol & HistoryRoutingLogic & HistoryDataPassing)?
    
    private var historyList : [History]?
    
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
        interactor?.requestHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.requestHistory()
    }
    
    func displayList(viewModel: HistoryModel.List.ViewModel) {
        historyList = viewModel.historyList
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

extension historyviewController {
    
    private func setup() {
        let viewController = self
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter()
        let router = HistoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
