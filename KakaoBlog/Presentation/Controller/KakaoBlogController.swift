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
    var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search blog"
        sc.searchBar.barTintColor = .systemBackground
        sc.obscuresBackgroundDuringPresentation = false
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
        viewModel.kakaoBlogSubject.bind(to: selfView.tableView.rx.items(cellIdentifier: KakaoBlogCell.identifier, cellType: KakaoBlogCell.self)) { index, item, cell in
            cell.configureUI(item: item)
        }.disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.debounce(.milliseconds(300), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] query in
            self?.viewModel.querySubject.onNext(query ?? "")
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
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
}
