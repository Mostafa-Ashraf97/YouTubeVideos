//
//  DetailsViewController.swift
//  Youtube
//
//  Created by Crypto on 10/8/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var lblVideoTitle: UILabel!
    
    @IBOutlet weak var lblVideoPublishedDate: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textViewVideoDescription: UITextView!
    
    // MARK: - Vars
    var video: Video?
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard video != nil else {return}
        
        //Create the Embed URL
        
        let embedURL = Constants.YT_EMBED_URL + video!.videoID
        
        // Load Video into WebView
        let url = URL(string: embedURL)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Set other attributes
        lblVideoTitle.text = video!.videoTitle
        textViewVideoDescription.text = video!.videoDescription
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        lblVideoPublishedDate.text = dateFormatter.string(from: video!.videoPublishedDate)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
