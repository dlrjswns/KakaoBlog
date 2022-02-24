//
//  KakaoBlogUsecase.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift

class KakaoBlogUsecase {
    private let repository: KakaoBlogRepository
    
    init(repository: KakaoBlogRepository) {
        self.repository = repository
    }
    
    func fetchKakaoBlog(query: String) -> Observable<Result<KakaoBlogEntity, KakaoError>> {
        return repository.fetchKakaoBlog(query: query)
    }
    
    func fetchKakaoBlogModel(entity: KakaoBlogEntity) -> [KakaoBlogModel] {
        var kakaoBlogModels: [KakaoBlogModel] = []
        _ = entity.kakaoBlogs.map { kakaoBlog in
            let kakaoBlogModel = KakaoBlogModel(blogname: kakaoBlog.blogname ?? "", thumbnail: kakaoBlog.thumbnail ?? "", title: removeBandSlashB(str: kakaoBlog.title))
            kakaoBlogModels.append(kakaoBlogModel)
        }
        return kakaoBlogModels
    }
    
    func removeBandSlashB(str: String?) -> String {
        guard let str = str else { return "" }
        let removeBString = str.components(separatedBy: "<b>").joined()
        return removeBString.components(separatedBy: "</b>").joined()
    }
    
    func formatDate(str: String?) -> Date {
        guard let str = str else { return Date() }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let formateDate = formatter.date(from: str) else { return Date() }
        return formateDate
    }
}
