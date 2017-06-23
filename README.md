# StatePatternWithReachability
StatePatternとReachabilityを組み合わせたサンプルです。


## ReachabilityObserver
参照を保持しておくことを想定。初期化した際、接続可能性が変化した際に`NotificationCenter`経由で通知する。
通知は以下のように定義：

```
extension Notification.Name{
    static let ReachableViaWifi = Notification.Name("ReachableViaWifi")	//Wifi経由で通信できる時
    static let ReachableViaCellular = Notification.Name("ReachableViaCellular")	//セルラー回線で通信可能時
    static let Unreachable = Notification.Name("Unreachable")	//通信不可能時
}
```

## 参考
- Reachability公式
- Stateパターン（木下さんの記事）
