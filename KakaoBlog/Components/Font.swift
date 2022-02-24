//
//  Font.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

class NormalBoldLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SmallItalicLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .italicSystemFont(ofSize: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
