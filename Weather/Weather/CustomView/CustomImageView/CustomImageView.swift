//
//  CustomImageView.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import UIKit

final class CustomImageView: UIImageView {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        self.imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                self.image = nil
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let imageToCache = UIImage(data: data) else { return }
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                self.imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
        }.resume()
    }

}
