//
//  CacheManager.swift
//  Youtube
//
//  Created by Crypto on 10/8/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cacheDictionary = [String : Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        // Store image data and take the url as the key
        cacheDictionary[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        // get the data for the key "url"
        return cacheDictionary[url]
    }
}
