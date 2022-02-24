//
//  KakaoBlogRepository.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift

protocol KakaoBlogRepository {
    func fetchKakaoBlog(query: String) -> Observable<Result<KakaoBlogEntity, KakaoError>>
}

enum KakaoError: Error {
    case urlError
    case decodeError
    
    var errorMessage: String? {
        switch self {
        case .urlError:
            return "올바르지않는 url 입니다"
        case .decodeError:
            return "Decode 에러"
        }
    }
}
