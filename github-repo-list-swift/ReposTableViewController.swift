//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    @IBOutlet var tableView1: UITableView!
    
    var store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView.accessibilityLabel = "tableView1"
        
        GithubAPIClient.getRepositories{
            
            DispatchQueue.main.async {
                // your code that touches the UI here, like, maybe:
                self.tableView1.reloadData()
            }
            
        } // fetch the git repos, populate the local datastore, reload table view
        
        

        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        let itemTitle = store.repositories[indexPath.row]
        cell.textLabel?.text = itemTitle["full_name"] // its ok to force unwrap a UI element
        return cell
    }
    


    // MARK: - Table view data source
 

}
