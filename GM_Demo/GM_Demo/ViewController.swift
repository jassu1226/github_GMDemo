//
//  ViewController.swift
//  GM_Demo
//
//  Created by jaswanth alahari on 4/28/19.
//  Copyright © 2019 jaswanth alahari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties and Outlet connections
    
    @IBOutlet weak var tableView: UITableView!
    let url = "https://api.github.com/repos/jassu1226/github_GMDemo/commits"
    var commitsDataSource = [Commit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getCommitDetails()
       
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //MARK: - Networking and JSON Parsing
    
    func getCommitDetails()  {
        
        self.commitsDataSource.removeAll()
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let commitResponseJSON: JSON = JSON(response.result.value ?? "Network Issues")
                for  commitValues in commitResponseJSON.array!  {
                    
                    let tempCommit = Commit()
                    tempCommit.commitName = commitValues["commit"]["author"]["name"].string!
                    tempCommit.CommitMessage = commitValues["commit"]["message"].string!
                    tempCommit.commitId = commitValues["commit"]["tree"]["sha"].string!
                    
                    self.commitsDataSource.append(tempCommit)
                }
            }else {
                print("Error: \(String(describing: response.result.error))")
                
            }
            self.tableView.reloadData()
        }
        
        
    }

    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitDetails", for: indexPath) as! CommitDetailCell
        
        cell.commiterName.text = commitsDataSource[indexPath.row].commitName
        cell.commitMsg.text = commitsDataSource[indexPath.row].CommitMessage
        cell.commitId.text = commitsDataSource[indexPath.row].commitId
        
        return cell
    }
    
    // MARK: - Tableview delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

