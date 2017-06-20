//
//  APIClient.swift
//  StatePatternWithReachability
//
//  Created by yuu ogasawara on 2017/06/16.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

class APIClient:ReachabilityAwareble{
    //シングルトン
    static let shared = APIClient()
    
    var reachabilityState: ReachabilityState
    var apiFetcher:APIFetcher?
    
    private init() {
        self.reachabilityState = Unknown()
        
        registerNotification()
    }
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    func sendRequestToFetchData(parameters:[String:Any]) {
        reachabilityState.sendRequest(params: parameters,
                                      sender: self)
    }
    
    func change(state:ReachabilityState) {
        self.reachabilityState = state
    }
    
}


// MARK: - 通知の登録
extension APIClient{
    func registerNotification() {
        let center = NotificationCenter.default
        
        center.addObserver(forName: .ReachableViaWifi,
                           object: nil,
                           queue: nil){ notification in
            self.change(state: Online())
        }
        
        center.addObserver(forName: .ReachableViaCellular,
                           object: nil,
                           queue: nil){ notification in
            self.change(state: Online())
        }
        
        center.addObserver(forName: .Unreachable,
                           object: nil,
                           queue: nil){ notification in
            self.change(state: Offline())
        }
    }
}
