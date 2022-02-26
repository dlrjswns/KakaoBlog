//
//  KakaoBlogRepositoryImpl.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift
import RxCocoa

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
}

extension KakaoBlogRepositoryImpl {
    struct KakaoAPI {
        static let scheme = "https"
        static let host = "dapi.kakao.com"
        static let path = "/v2/search/blog"
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
        components.path = KakaoAPI.path
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        return components
    }
}


//https://dapi.kakao.com/v2/search/web?query="이효"
//Authorization KakaoAK 886464bb112952f2cc3d369ea62f3cdb

