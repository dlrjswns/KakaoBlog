//
//  AlamofireManager.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/03/01.
//

import Alamofire

final class AlamofireManager {
    static let shared = AlamofireManager()
    
    let session: Session
    
    let interceptor: RequestInterceptor = Interceptor(interceptors: [
        BaseInterceptor()
    ])
    
//    let interceptorPractice: Interceptor = Interceptor(adapters: <#T##[RequestAdapter]#>, retriers: <#T##[RequestRetrier]#>, interceptors: <#T##[RequestInterceptor]#>)
    
    //RequestInterceptor가 프로토콜인데 이를 채택한 클래스가 Interceptor 클래스이고
    //RequestAdaptor와 RequestRetrier가 RequestInterceptor프로토콜에 존재하기때문에 Interceptor에서 단일 혹은 배열로써 사용가능 
    
    let eventMonitors: [EventMonitor] = [
        BaseEventMonitor()
    ]
    
    private init() {
        session = Session(interceptor: interceptor, eventMonitors: eventMonitors)
    }
}
