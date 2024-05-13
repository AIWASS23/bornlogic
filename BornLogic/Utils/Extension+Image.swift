//
//  Extension+Image.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import UIKit

fileprivate class NewsImageCache {
    static let shared = NewsImageCache()
    var cache: [String : UIImage] = [:]
}

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode

        if let image = NewsImageCache.shared.cache[url.absoluteString] {
            self.image = image
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }

            NewsImageCache.shared.cache[url.absoluteString] = image

            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }

    func loadImageFrom(urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }

}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
