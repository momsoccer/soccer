//
//  TeamBoardTableViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit

class TeamBoardTableViewController: UITableViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "데이터 갱신")
        refreshControl?.tintColor = UIColor.red
        
        refreshControl?.addTarget(self,
                                  action: #selector(TeamBoardTableViewController.handleRefresh(refreshControl:)),
                                  for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.perform(#selector(self.endRefresh), with: nil, afterDelay: 1.0)
        
    }
    
    //새로고침시..
    func endRefresh() {
        refreshControl?.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Row " + String((indexPath as NSIndexPath).row)
        
        return cell
    }
    
    func viewForObserve() -> UIView{
        
        return self.tableView
    }

    
}
