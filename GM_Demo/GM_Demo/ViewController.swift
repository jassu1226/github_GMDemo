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
    
    @IBOutlet weak var tableView: UITableView!
    let url = "https://api.github.com/repos/jassu1226/github_GMDemo/commits"
    var commitsDataSource = [Commit]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getCommitDetails() -> [Commit] {
        var commits = [Commit]()
        return commits
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitDetails", for: indexPath) as! CommitDetailCell
        
        return cell
    }


}

