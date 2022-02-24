//
//  BaseView.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        
    }
    
    func layout() {
        
    }
}
