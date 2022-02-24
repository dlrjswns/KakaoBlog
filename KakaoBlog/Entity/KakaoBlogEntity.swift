//
//  KakaoBlogEntity.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import Foundation

struct KakaoBlogEntity: Decodable {
    let kakaoBlogs: [KakaoBlog]
    
    enum CodingKeys: String, CodingKey {
        case kakaoBlogs = "documents"
    }
}

struct KakaoBlog: Decodable {
    let blogname: String?
    let contents: String?
    let datetime: String?
    let thumbnail: String?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case blogname, contents, datetime, thumbnail, title, url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.blogname = try? values.decode(String.self, forKey: .blogname)
        self.contents = try? values.decode(String.self, forKey: .contents)
        self.datetime = try? values.decode(String.self, forKey: .datetime)
        self.thumbnail = try? values.decode(String.self, forKey: .thumbnail)
        self.title = try? values.decode(String.self, forKey: .title)
        self.url = try? values.decode(String.self, forKey: .url)
    }
}
