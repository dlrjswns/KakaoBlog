//
//  KakaoBlogRepositoryImpl.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift
import RxCocoa
import Alamofire

class KakaoBlogRepositoryImpl: KakaoBlogRepository {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchKakaoBlog(query: String) -> Observable<Result<KakaoBlogEntity, KakaoError>> {
        let urlRequestResult = getKakaoBlogURLRequest(query: query)
        switch urlRequestResult {
            case .failure(let error):
                return .just(.failure(error))
            case .success(let urlRequest):
                print("urlrEquet = \(urlRequest)")
                return session.rx.data(request: urlRequest).map { data in
                    print("Data = \(data)")
                    do {
                        let kakaoBlogEntity = try JSONDecoder().decode(KakaoBlogEntity.self, from: data)
                        return .success(kakaoBlogEntity)
                    } catch {
                        let error = KakaoError.decodeError
                        return .failure(error)
                    }
                }
        }
    }
    
    
    func fetchKakaoBookWithAlamofire(query: String) {
        guard let url = getKakaoBlogURLComponents(query: query).url else { return }
       let headers =  HTTPHeaders(["Authorization" : "KakaoAK 886464bb112952f2cc3d369ea62f3cdb"])
//        let interceptor: RequestInterceptor =
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseDecodable(of: KakaoBlogEntity.self) { response in
//            debugPrint("response = \(response)")
//        }
        AF.request(url, headers: headers).responseData { response in
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                
            }
            guard let data = response.data else { return }
            do{
                let entity = try JSONDecoder().decode(KakaoBlogEntity.self, from: data)
                print("entity = \(entity)")
            }catch{
                
            }
        }
        
    }
}

extension KakaoBlogRepositoryImpl {
    struct KakaoAPI {
        static let scheme = "https"
        static let host = "dapi.kakao.com"
        static let blogPath = "/v2/search/blog"
        static let bookPath = "/v3/search/book"
    }
    
    func getKakaoBlogURLRequest(query: String) -> Result<URLRequest, KakaoError> {
        guard let url = getKakaoBlogURLComponents(query: query).url else {
                let error = KakaoError.urlError
                return .failure(error)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = [
            "Authorization" : "KakaoAK 886464bb112952f2cc3d369ea62f3cdb"
        ]
        return .success(urlRequest)
    }
    
    private func getKakaoBlogURLComponents(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = KakaoAPI.scheme
        components.host = KakaoAPI.host
        components.path = KakaoAPI.blogPath
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        return components
    }
    
    private func getKakaoBookURLComponents(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = KakaoAPI.scheme
        components.host = KakaoAPI.host
        components.path = KakaoAPI.bookPath
        components.queryItems = [
            URLQueryItem(name: "target", value: "title"),
            URLQueryItem(name: "query", value: query)
        ]
        return components
    }
}


//https://dapi.kakao.com/v3/search/book?target=title&query=안녕

