//
//  HistoryInteractor.swift
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

protocol HistoryBusinessLogic {
  func requestHistory()
}

protocol HistoryDataStore {
}

class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
  var presenter: HistoryPresentationLogic?
  
  func requestHistory() {
    let list = LocalData.loadHistory()
    let response = HistoryModel.List.Response(historyList: list)
      presenter?.presentList(response: response)
  }
}
