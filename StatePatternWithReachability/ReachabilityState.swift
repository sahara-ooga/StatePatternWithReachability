//MARK: Reachability Protocol
protocol ReachabilityAwareble{
    var reachabilityState:ReachabilityState { get set }
    func change(state:ReachabilityState)
}

protocol ReachabilityState{
    func stateDescription()
    func sendRequest(params:[String:Any],
                                sender:ReachabilityAwareble)
}

//MARK: ReachabilityState
struct Offline:ReachabilityState{
    func stateDescription(){
        print("オフラインです")
    }
    
    func sendRequest(params:[String:Any],
                                sender:ReachabilityAwareble){
        print("オフラインなので送信できません")
    }
}

struct Online:ReachabilityState {
    func sendRequest(params:[String:Any],
                                sender:ReachabilityAwareble){
        print("取得リクエストを送信します")
        
        
        let apiClient = sender as! APIClient
        let apiFetcher = APIFetcher()
        apiClient.apiFetcher = apiFetcher
        apiFetcher.sendRequest(params: params)
    }
    
    func stateDescription(){
        print("オンラインです")
    }
}

struct Unknown:ReachabilityState {
    func stateDescription(){
        print("不明です")
    }
    
    func sendRequest(params:[String:Any],
                                sender:ReachabilityAwareble){
        print("取得リクエストを送信します")
    }
}
