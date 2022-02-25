//
//  KakaoBlogCell.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

class KakaoBlogCell: UITableViewCell {
    
    static let identifier = "KakaoBlogCell"
    
    let blogNameLabel = NormalBoldLabel()
    let thumbNailImageView = UIImageView()
    let titleLabel = SmallItalicLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(thumbNailImageView)
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbNailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbNailImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        thumbNailImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thumbNailImageView.widthAnchor.constraint(equalToConstant: frame.width/4).isActive = true
        
        addSubview(blogNameLabel)
        blogNameLabel.translatesAutoresizingMaskIntoConstraints = false
        blogNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.height / 4).isActive = true
        blogNameLabel.leftAnchor.constraint(equalTo: thumbNailImageView.rightAnchor, constant: 15).isActive = true
        blogNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: blogNameLabel.bottomAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height/4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: thumbNailImageView.rightAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func attribute() {
//        thumbNailImageView.contentMode = .scaleAspectFill
    }
    
    func configureUI(item: KakaoBlogModel) {
        thumbNailImageView.loadImage(thumbNailUrl: item.thumbnail)
        blogNameLabel.text = item.blogname
        titleLabel.text = item.title
    }
}
