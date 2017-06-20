//
//  FetcherState.swift
//  StatePatternWithReachability
//
//  Created by yuu ogasawara on 2017/06/16.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation


//MARK: - APIFetcherState Protocol
protocol APIFetcherStateAwareble{
    var apiFetcherState:APIFetcherState { get set }
    func change(state:APIFetcherState)
}

protocol APIFetcherState{
    func sendRequestToFetchData(params:[String:Any],
                                fetcher:APIFetcherStateAwareble)
}

//MARK: 各通信状態
struct NotConnected:APIFetcherState{
    func sendRequestToFetchData(params: [String : Any],
                                fetcher: APIFetcherStateAwareble) {
        print("情報取得処理を開始します")
        
        //do fetching
        
        fetcher.change(state: InProgress())
    }
}

struct InProgress:APIFetcherState{
    func sendRequestToFetchData(params: [String : Any],
                                fetcher: APIFetcherStateAwareble) {
        //do something
    }
}

struct Finished:APIFetcherState{
    func sendRequestToFetchData(params: [String : Any],
                                fetcher: APIFetcherStateAwareble) {
        fetcher.change(state: NotConnected())
    }
    
}

public struct Canceled:APIFetcherState{
    func sendRequestToFetchData(params: [String : Any],
                                fetcher: APIFetcherStateAwareble) {
        fetcher.change(state: NotConnected())
    }
}

public struct NetworkError:APIFetcherState{
    var errorDescription:String = ""
    
    func sendRequestToFetchData(params: [String : Any],
                                fetcher: APIFetcherStateAwareble) {
        //add error description
        print("エラーが発生しました:\(errorDescription)")
    }
}
