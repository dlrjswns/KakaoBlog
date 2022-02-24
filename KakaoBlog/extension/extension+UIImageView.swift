//
//  extension+UIImageView.swift
//  KakaoBlog
//
//  Created by 이건준 on 2022/02/24.
//

import UIKit

class MemoryCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    func loadImage(thumbNailUrl: String?) {
        guard let thumbNailUrl = thumbNailUrl else { return }
        let cacheKey = NSString(string: thumbNailUrl)
        
            if let cacheImage = MemoryCacheManager.shared.object(forKey: cacheKey) {
                self.image = cacheImage
                return
            }
        
        if let url = URL(string: thumbNailUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                DispatchQueue.main.async {
                    if error != nil {
                        self.image = UIImage()
                    }
                }
                
                DispatchQueue.main.async {
                    if let data = data,
                       let thumbNailImage = UIImage(data: data) {
                        MemoryCacheManager.shared.setObject(thumbNailImage, forKey: cacheKey)
                        self.image = thumbNailImage
                    }
                }
            }.resume()
        }
    }
}
