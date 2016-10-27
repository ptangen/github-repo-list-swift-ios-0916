//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    class func getRepositories(with completion:@escaping ()->Void) {
        
        let store = ReposDataStore.sharedInstance
        let urlString = "https://api.github.com/repositories?client_id=50db7210649624497a09&client_secret=abf478ea14c9877c65b823ba05e6514723086dca"
        let url = URL(string: urlString)
        
        if let unwrappedURL = url {
            let session = URLSession.shared
            let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
                if let unwrappedData = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [AnyObject]

                        for repo in responseJSON {
                            let full_name = repo["full_name"] as! String
                            let id = repo["id"] as! Int
                            let html_url = repo["html_url"] as! String
                            let repoDict = ["id": String(id), "full_name": full_name, "html_url": html_url] // create the inner dictionary
                            store.repositories.append(repoDict)
                        
                        }
                        
                        completion()
                        
                    } catch {
                        print("An error occured when creating responseJSON")
                    }
                }
                
                
            }
            task.resume()
        }
    }
}
    


