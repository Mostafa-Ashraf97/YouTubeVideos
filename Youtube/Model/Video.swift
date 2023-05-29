//
//  Video.swift
//  Youtube
//
//  Created by Crypto on 10/5/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import Foundation
struct Video: Decodable {
    
    var videoID = ""
    var videoTitle = ""
    var videoDescription = ""
    var videThumbnail = ""
    var videoPublishedDate = Date()
    
    
    //MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case videoPublishedDate = "publishedAt"
        case videoTitle = "title"
        case videoDescription = "description"
        case videThumbnail = "url"
        case videoID = "videoId"
    }
    
    //MARK: - Json Decoder
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)

        // Parsing our attributes
        self.videoTitle = try snippetContainer.decode(String.self, forKey: .videoTitle)
        self.videoDescription = try snippetContainer.decode(String.self, forKey: .videoDescription)
        self.videoPublishedDate = try snippetContainer.decode(Date.self, forKey: .videoPublishedDate)
        
        // Parse Thumbnails
        let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
               
               let highContainer = try thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.videThumbnail = try highContainer.decode(String.self, forKey: .videThumbnail)
         
        
//         Parse vide ID
         let resourceIDContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoID = try resourceIDContainer.decode(String.self, forKey: .videoID)
    }
}
