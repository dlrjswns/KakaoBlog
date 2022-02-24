//
//  KakaoBlogViewModel.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift

class KakaoBlogViewModel {
    private let usecase: KakaoBlogUsecase
    var disposeBag = DisposeBag()
    
    //ViewModel -> View
    var kakaoBlogSubject = BehaviorSubject<[KakaoBlogModel]>(value: [])
    
    //View -> ViewModel
    var querySubject = BehaviorSubject<String>(value: "")
    
    init(usecase: KakaoBlogUsecase) {
        self.usecase = usecase

        observableQuerySubject()
    }
    
    func searchBlog(query: String) {
        usecase.fetchKakaoBlog(query: query).subscribe(onNext: { [weak self] fetchResult in
            switch fetchResult {
                case .failure(let error):
                        break
                case .success(let entity):
                    guard let kakaoBlogModels = self?.usecase.fetchKakaoBlogModel(entity: entity) else { return }
                    self?.kakaoBlogSubject.onNext(kakaoBlogModels)
            }
        }).disposed(by: disposeBag)
    }
    
    func observableQuerySubject() {
        querySubject.asObservable().subscribe(onNext: { [weak self] query in
            self?.searchBlog(query: query)
        }).disposed(by: disposeBag)
    }
    
}
