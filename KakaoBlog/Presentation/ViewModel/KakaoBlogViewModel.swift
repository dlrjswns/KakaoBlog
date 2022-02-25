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
    let kakaoBlogMenus: Driver<[KakaoBlogModel]>
//    var kakaoBlogSubject = BehaviorRelay<[KakaoBlogModel]>(value: [])
    let errorMessage: Signal<KakaoError>
    
    //View -> ViewModel
    let queryInput: AnyObserver<String>
    let fetchMenus: AnyObserver<Void>
    
    init(usecase: KakaoBlogUsecase) {
        self.usecase = usecase
        let querySubject = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        let menus = BehaviorSubject<[KakaoBlogModel]>(value: [])
        let activating = BehaviorSubject<Bool>(value: false)
        let error = PublishSubject<KakaoError>()
        
        fetchMenus = fetching.asObserver()
        queryInput = querySubject.asObserver()
        errorMessage = error.asSignal(onErrorJustReturn: KakaoError.defaultError)
        kakaoBlogMenus = menus.asDriver(onErrorJustReturn: [])
        
        querySubject.subscribe(onNext: { query in
            print("query = \(query)")
            _ = usecase.fetchKakaoBlog(query: query).map { result in
                print("씨발")
                switch result {
                    case .failure(let err):
                        print("err = \(err.errorMessage ?? "tlqkf")")
                        error.onNext(err)
                    case .success(let kakaoBlogEntity):
                        print("kakao = \(kakaoBlogEntity)")
                        menus.onNext(usecase.fetchKakaoBlogModel(entity: kakaoBlogEntity))
                }
            }
        }).disposed(by: disposeBag)
        
        
//        let fetchKakaoBlogEntity = usecase.fetchKakaoBlog(query: "").share()
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

    
//    func searchBlog(query: String) {
//        usecase.fetchKakaoBlog(query: query).subscribe(onNext: { [weak self] fetchResult in
//            switch fetchResult {
//                case .failure(let error):
//                    break
//                case .success(let entity):
//                    guard let kakaoBlogModels = self?.usecase.fetchKakaoBlogModel(entity: entity) else { return }
//                    self?.kakaoBlogSubject.accept(kakaoBlogModels)
//            }
//        }).disposed(by: disposeBag)
//    }
//
//    func observableQuerySubject() {
//        queryRelay.asObservable().subscribe(onNext: { [weak self] query in
//            self?.searchBlog(query: query)
//        }).disposed(by: disposeBag)
//    }
    
}
