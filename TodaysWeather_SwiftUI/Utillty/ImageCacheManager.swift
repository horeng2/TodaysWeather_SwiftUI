//
//  ImageCacheManager.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/14.
//

import SwiftUI
import Combine

class ImageCacheManager: ObservableObject {
    static let shared = ImageCacheManager()
    @Published var image = UIImage()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private func loadCacheData(for key: String) -> UIImage? {
        let url = NSString(string: key)
        return self.cache.object(forKey: url as NSString )
    }
    
    private func saveCacheData(of image: UIImage, for key: String) {
        let url = NSString(string: key)
        self.cache.setObject(image, forKey: url)
    }
    
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        if let cachedImage = self.loadCacheData(for: url) {
            self.image = cachedImage
            return
        }
        let task = URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data,
                  let newImage = UIImage(data: data) else {
                return
            }
            self.saveCacheData(of: newImage, for: url)
            self.image = newImage
        }
        task.resume()
    }
}
