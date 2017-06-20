//
//  Fetcher.swift
//  StatePatternWithReachability
//
//  Created by yuu ogasawara on 2017/06/16.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

class APIFetcher:APIFetcherStateAwareble {
    var apiFetcherState: APIFetcherState = NotConnected()
    
    func change(state: APIFetcherState) {
        self.apiFetcherState = state
    }
    
    func sendRequest(params:[String:Any]){
        apiFetcherState.sendRequestToFetchData(params: params,
                                               fetcher: self)
    }
}
