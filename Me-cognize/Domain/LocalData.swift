//
//  LocalData.swift
//  Me-cognize
//
//  Created by Hailey on 2023/08/12.
//

import Foundation

enum LocalDataKey: String {
    /// [History]
    case histories
    
}

struct LocalData{
    
    static func saveHistory(_ each : History,  onSuccess: @escaping () -> (), onFail: @escaping () -> ()){
     
        var localData = loadHistory()
        localData.append(each)
        
        guard let data = try? PropertyListEncoder().encode(localData) else {
            onFail()
            return
        }
        UserDefaults.standard.set(data, forKey: LocalDataKey.histories.rawValue)
        onSuccess()
    }

    static func loadHistory() -> [History] {
        guard let data = UserDefaults.standard.data(forKey: LocalDataKey.histories.rawValue),
              let list = try? PropertyListDecoder().decode([History].self, from: data) else {
            return []
        }
        return list
        
    }
}
