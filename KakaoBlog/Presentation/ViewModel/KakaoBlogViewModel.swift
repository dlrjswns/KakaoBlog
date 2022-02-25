//
//  KakaoBlogViewModel.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import RxSwift
import RxCocoa

class KakaoBlogViewModel {
    private let usecase: KakaoBlogUsecase
    var disposeBag = DisposeBag()
    
    //ViewModel -> View
//    let kakaoBlogSubject: Driver<[KakaoBlogModel]?>
    var kakaoBlogSubject = BehaviorRelay<[KakaoBlogModel]>(value: [])
//    let errorMessage: Signal<String?>
    
    //View -> ViewModel
    var queryRelay = BehaviorRelay<String>(value: "")
    
    init(usecase: KakaoBlogUsecase) {
        self.usecase = usecase

//        observableQuerySubject()
        var queryString = ""
        
//        let queryObservable = queryRelay.asObservable().subscribe(onNext: { query in
//            usecase.fetchKakaoBlog(query: query)
//        }).disposed(by: disposeBag)
        
//        let fetchKakaoBlogEntity = usecase.fetchKakaoBlog(query: "이효").share()
//
//
//
//        let fetchKakaoBlogModel = fetchKakaoBlogEntity.map { result -> [KakaoBlogModel]? in
//            guard case .success(let kakaoBlogEntity) = result else { return nil }
//            return usecase.fetchKakaoBlogModel(entity: kakaoBlogEntity)
//            }
//
//        let fetchKakaoBlogError = fetchKakaoBlogEntity.map { result -> String? in
//            guard case .failure(let kakaoBlogError) = result else { return nil }
//            return kakaoBlogError.errorMessage
//        }
//
//        self.errorMessage = fetchKakaoBlogError.asSignal(onErrorJustReturn: KakaoError.defaultError.errorMessage ?? "")
//        self.kakaoBlogSubject = fetchKakaoBlogModel.asDriver(onErrorJustReturn: [])
        }

    
    func searchBlog(query: String) {
        usecase.fetchKakaoBlog(query: query).subscribe(onNext: { [weak self] fetchResult in
            switch fetchResult {
                case .failure(let error):
                    break
                case .success(let entity):
                    guard let kakaoBlogModels = self?.usecase.fetchKakaoBlogModel(entity: entity) else { return }
                    self?.kakaoBlogSubject.accept(kakaoBlogModels)
            }
        }).disposed(by: disposeBag)
    }

    func observableQuerySubject() {
        queryRelay.asObservable().subscribe(onNext: { [weak self] query in
            self?.searchBlog(query: query)
        }).disposed(by: disposeBag)
    }
    
}
