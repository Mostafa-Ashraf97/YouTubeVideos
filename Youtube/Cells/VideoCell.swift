//
//  VideoCell.swift
//  Youtube
//
//  Created by Crypto on 10/7/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    @IBOutlet weak var lblVideoTitle: UILabel!
    @IBOutlet weak var lblVideoPublishedDate: UILabel!
    
    //MARK: - vars
    var video: Video?
    // MARK: - Cell Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func generateCell (_ myVideo: Video) {
        self.video = myVideo
        // Make sure  video has value
        guard self.video != nil else {return}
        lblVideoTitle.text = video!.videoTitle
        
        //Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        self.lblVideoPublishedDate.text = dateFormatter.string(from: video!.videoPublishedDate)
        
        guard self.video!.videThumbnail != "" else {return}
        
        // Check Cache to download data
        if let cachedData = CacheManager.getVideoCache(self.video!.videThumbnail) {
            
            self.videoThumbnailImageView.image = UIImage(data: cachedData)
            return // we don't need to contuniue
        }
        
        // Download Thumbnail Data
        let url = URL(string: self.video!.videThumbnail)
        
        guard url != nil else {return}
        
        // URL Session object
        let session = URLSession.shared
        
        //Data Task from URLSession object
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil || data != nil {
                
                // Save video data in Cache Manager
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                //check if video url equals to the download url
                if url!.absoluteString != self.video?.videThumbnail {
                    //video cell is recycled for another video which doesn't match with the one in thumbnail
                    return
                }
                
                // create image object
                let image = UIImage(data: data!)
                
                // Set the imageView
                DispatchQueue.main.async {
                    self.videoThumbnailImageView.image = image
                    
                }
            }
            
        }
        
        // Start data task
        dataTask.resume()
        
    }
    
}
