//
//  ReachabilityObserver.swift
//  StatePatternWithReachability
//
//  Created by yuu ogasawara on 2017/06/16.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

class ReachabilityObserver{
    static let shared = ReachabilityObserver()
    
    private var reachability:AMReachability?
    
    /// 初期化時に、通信状況の取得・監視設定を行う
    private init() {
        reachability = AMReachability()
        
        guard let reachability = reachability else {
            return
        }
        
        let center = NotificationCenter.default
        
        if reachability.isReachable == true {
            
            print("インターネット接続あり")
            if reachability.isReachableViaWiFi{
                center.post(.init(name: .ReachableViaWifi))
            }else{
                center.post(.init(name: .ReachableViaCellular))
            }
        } else {
            print("インターネット接続なし")
            center.post(.init(name: .Unreachable))
        }
        
        //接続ステータスが変化した時の挙動の設定の仕方
        //ここではクロージャを使用している。Notificationを使ったやり方はGithub参照。
        reachability.whenReachable = { reachability in
            if reachability.isReachableViaWiFi{
                center.post(.init(name: .ReachableViaWifi))
            }else{
                center.post(.init(name: .ReachableViaCellular))
            }
            
            //このクロージャはバックグラウンドで実行されるので、
            //UI周りは明示的にメインスレッドで実行するように指定する
            DispatchQueue.main.async {
                
                print("インターネット接続ありになった時の処理")
                
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                print("")
            }
        }
        
        reachability.whenUnreachable = { reachability in
            center.post(.init(name: .Unreachable))
            
            DispatchQueue.main.async {
                
                //インターネット接続なしになった時の処理
                //self.delegate?.connectionDidChange(.Unreachable)
            }
        }
        
        //通信状況の監視を開始
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

    }
    
    deinit {
        reachability?.stopNotifier()
    }
    
    var reachable:Bool{
        get {
            return reachability!.isReachable
        }
    }
}

//接続可能になったタイミング
//Wifiかセルラー回線か
//接続不可能になったタイミング
enum ConnectionState{
    case ReachableViaWifi
    case ReachableViaCellular
    case Unreachable
}

extension Notification.Name{
    static let ReachableViaWifi = Notification.Name("ReachableViaWifi")
    static let ReachableViaCellular = Notification.Name("ReachableViaCellular")
    static let Unreachable = Notification.Name("Unreachable")
}
