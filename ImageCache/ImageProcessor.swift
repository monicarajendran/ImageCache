//
//  ImageProcessor.swift
//  ImageCache
//
//  Created by Monica on 12/04/19.
//  Copyright © 2019 Monica. All rights reserved.
//

import Foundation
import UIKit


//MARK: Cache
fileprivate let defaultUrlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "MainAppDiskSpace")

protocol NetworkSession {
    func loadImage(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    
    func loadImage(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
            }.resume()
    }
}

private struct StaticImageProcessor {
    static var singleton: ImageProcessor? = nil
}

class ImageProcessor {
    
    class var shared: ImageProcessor {
        if let instance = StaticImageProcessor.singleton {
            return instance
        }
        StaticImageProcessor.singleton = ImageProcessor()
        return StaticImageProcessor.singleton!
    }
    
    class func reset() {
        StaticImageProcessor.singleton = nil
    }
    
    private init() {}
    
    func downloadImage(session: NetworkSession = URLSession.shared, cache: URLCache = defaultUrlCache, url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        session.loadImage(from: url) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let imageToCache = UIImage(data: data) {
                completion(imageToCache, nil)
            } else {
                completion(nil, nil) // set proper error
            }
        }
    }
}
