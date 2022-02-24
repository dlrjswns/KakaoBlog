//
//  KakaoSearchView.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

class KakaoBlogView: BaseView {
    let tableView = UITableView()
    
    override func layout() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
