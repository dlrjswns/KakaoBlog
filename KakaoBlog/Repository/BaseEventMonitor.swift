//
//  BaseEventMonitor.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/03/01.
//

import Alamofire

class BaseEventMonitor: EventMonitor {
    let queue: DispatchQueue = DispatchQueue(label: "신기하다") //이 프로퍼티가 그냥 Alamofire에 정의되어있는 프로퍼티인듯, 자동완성되버림 ㅇㅅ ㅇ
                                                                //내가 볼때는 queue라는 이름으로 DispatchQueue를 생성해주면 알아서 이 큐에 로깅하기위한 메소드를 쌓아올리지않을까 ??
    func requestDidFinish(_ request: Request) {
        //request가 끝나고 response를 보내기 직전에 호출
        print("Logging - requestDidFinish() called")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        //response를 받고난 이후
        print("Logging - didParseResponse() called")
    }
}
