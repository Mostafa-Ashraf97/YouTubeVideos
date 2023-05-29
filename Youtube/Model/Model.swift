//
//  Model.swift
//  Youtube
//
//  Created by Crypto on 10/5/20.
//  Copyright © 2020 Crypto. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched (_ videos: [Video])
    
}

class Model {
    
    //MARK: - Vars
    var delegate: ModelDelegate?
    
    // MARK: - Get videos
    func getVideos () {
        // URL Object
        let url = URL(string: Constants.API_URL)
        guard url != nil else {return}
        
        // URL Session object
        let session = URLSession.shared
        
        //Data Task from URLSession object
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil || data == nil {
                print(error!.localizedDescription)
                return
            }
            
            do {
                // Parsing data into Video Object
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                // dump(response) // If we wanna check our response output in the console
                // Return videos from delegate func
                if response.items != nil {
                    // Using DispatchQueue to throw the task to the main thread to avoid app cruch 
                    DispatchQueue.main.async {
                          self.delegate?.videosFetched(response.items!)
                    }
                  
                }
            }
            catch {
                
            }
        }
        
        // start data task 
        dataTask.resume()
    }
}
