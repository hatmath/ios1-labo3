//
//  imageDownloader.swift
//  labo3pokemon
//
//  Created by Simon Turcotte et Mathieu Hatin (Étudiants) on 2023-06-20.
//

import UIKit


class ImageDownloader {
// Singleton instance
static let shared = ImageDownloader()

private let queue = DispatchQueue(label: "imageDownloader", attributes:
    .concurrent)
private init() {}
    
func downloadImage(_ url: URL, completion: @escaping (UIImage?) -> Void) {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data, error == nil else {
        DispatchQueue.main.async {
            completion(nil)
        }
        return
    }
    
    let image = UIImage(data: data)
    DispatchQueue.main.async {
        completion(image)
        }
    }
    task.resume()
    }
}
