//
//  KakaoSearchController.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit
import RxCocoa
import RxSwift

class KakaoBlogController: BaseViewController {
    
    let selfView = KakaoBlogView()
//    var currentSortType: ScopeType = .blog
    
    var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search blog"
        sc.searchBar.barTintColor = .systemBackground
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.scopeButtonTitles = ["Blog", "Book"]
        sc.searchBar.showsScopeBar = true
        return sc
    }()
    
    private let viewModel: KakaoBlogViewModel
    
    init(viewModel: KakaoBlogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rp = KakaoBlogRepositoryImpl()
        rp.fetchKakaoBookWithAlamofire(query: "dk")
        viewModel.kakaoBlogMenus.bind(to: selfView.tableView.rx.items(cellIdentifier: KakaoBlogCell.identifier, cellType: KakaoBlogCell.self)) { index, item, cell in
            cell.configureUI(item: item)
        }.disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty.filter{ $0.count != 0 }.debounce(.milliseconds(300), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] query in
            self?.viewModel.fetchMenus.onNext(())
            self?.viewModel.queryInput.onNext(query)
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.emit(onNext: { error in
            guard let errorMessage = error.errorMessage else { return }
            print("에러 호출: \(errorMessage)")
        }).disposed(by: disposeBag)
        
        viewModel.activated.drive(onNext: { [weak self] isActivating in
            self?.selfView.loadingView.isHidden = !isActivating
        }).disposed(by: disposeBag)
        
        viewModel.scopeTypeObservable.subscribe(onNext: { [weak self] scopeType in
            switch scopeType {
            case .blog:
                self?.searchController.searchBar.placeholder = "Search blog"
                self?.configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: "Daum blog", preferredLargeTitle: true)
            case .book:
                self?.searchController.searchBar.placeholder = "Search book"
                self?.configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemPink, tintColor: .white, title: "Daum book", preferredLargeTitle: true)
            }
        }).disposed(by: disposeBag)
    }
    
    override func layout() {
        view.addSubview(selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func attribute() {
//        title = "Daum blog"
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.largeContentTitle = "Daum blog"
        
        selfView.tableView.register(KakaoBlogCell.self, forCellReuseIdentifier: KakaoBlogCell.identifier)
        selfView.tableView.delegate = self
        selfView.loadingView.isHidden = true
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension KakaoBlogController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let seletedIndex = searchController.searchBar.selectedScopeButtonIndex
        if seletedIndex == 0 {
//            searchController.searchBar.placeholder = "Search blog"
            viewModel.scopeTypeInput.onNext(.blog)
//            configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: "Daum blog", preferredLargeTitle: true)
        }else if seletedIndex == 1 {
//            searchController.searchBar.placeholder = "Search book"
            viewModel.scopeTypeInput.onNext(.book)
//            configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemPink, tintColor: .white, title: "Daum book", preferredLargeTitle: true)
        }
    }
}


