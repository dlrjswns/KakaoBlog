//
//  KakaoBlog+UITableView.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

extension KakaoBlogController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
