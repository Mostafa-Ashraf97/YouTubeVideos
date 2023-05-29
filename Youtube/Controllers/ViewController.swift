//
//  ViewController.swift
//  Youtube
//
//  Created by Crypto on 10/4/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    
    @IBOutlet weak var videosTableView: UITableView!
    
    // MARK: - Vars
    var model = Model()
    var videos = [Video]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        model.delegate = self
        model.getVideos()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Make sure that there is a selected video
        guard videosTableView.indexPathForSelectedRow != nil  else {
            return
        }
        
        // Get a reference to the selected video
        let selectedVideo = videos[videosTableView.indexPathForSelectedRow!.row]
        
        //Get a reference to detailed ViewController
        let detailsVC = segue.destination as! DetailsViewController
        
        // Set the video 
        detailsVC.video = selectedVideo
    }
    // MARK: - Model Delegate Methods
    
    func videosFetched(_ videos: [Video]) {
        self.videos = videos
        videosTableView.reloadData()
        
    }
// MARK: - Table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = videosTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.generateCell(videos[indexPath.row])
//        
        return cell
    }
    
}

