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
    var kakaoBlogData = BehaviorSubject<[KakaoBlogModel]>(value: [])
    
    //View -> ViewModel
//    var query = Behavior
    
    init(usecase: KakaoBlogUsecase) {
        self.usecase = usecase
        
        usecase.fetchKakaoBlog(query: "이효리").subscribe(onNext: { [weak self] fetchResult in
            switch fetchResult {
            case .failure(let error):
                    break
            case .success(let entity):
                let kakaoBlogModels = usecase.fetchKakaoBlogModel(entity: entity)
                self?.kakaoBlogData.onNext(kakaoBlogModels)
            }
        }).disposed(by: disposeBag)
    }
    
    
}
