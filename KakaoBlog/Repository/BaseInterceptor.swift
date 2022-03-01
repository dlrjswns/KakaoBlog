//
//  BaseInterceptor.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/03/01.
//

import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) { //RequestAdaptor
        //request로 보내고자하는 데이터를 중간에 가로채와서 무엇을 하고싶나요 ??
        var request = urlRequest
        request.headers = HTTPHeaders([
            .authorization("KakaoAK 886464bb112952f2cc3d369ea62f3cdb")
        ])
        
        let parameters = ["query" : "안녕"]
        
        do{
            request =  try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }catch{
            print("BaseInterceptor adapt() called - \(error)")
            completion(.failure(error))
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) { //RequestRetrier
        //만약에 서버에 request를 보낸 와중에 실패한다면 어떻게 하고싶나요 ??
        guard let statusCode = request.response?.statusCode else { return completion(.doNotRetry) }
        print("BaseInterceptor retry() called - \(statusCode)")
        
    }
}
