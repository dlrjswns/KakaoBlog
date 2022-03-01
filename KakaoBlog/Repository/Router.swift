//
//  Router.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/03/01.
//

import Alamofire

enum Router: URLRequestConvertible {
    case blog([String: String]), book([String: String])
    
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }
    
    var method: HTTPMethod {
        switch self {
            case .blog: return .get
            case .book: return .get
        }
    }
    
    var path: String {
        switch self {
            case .blog: return "/v2/search/blog"
            case .book: return "/v3/search/book"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case let .blog(parameters):
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case let .book(parameters):
            request = try JSONParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}
