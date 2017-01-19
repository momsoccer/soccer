//
//  UserMissionTableViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
//  pod 'SJSegmentedScrollView' 버전이 맞지 않기 때문에 메뉴얼로 최신을 받음... 리프레쉬가 안됨

import UIKit

class UserMissionTableViewController: UITableViewController {

    var testArray:[Int] = [1,2,3,4,5,6,7,9,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "데이터 갱신")
        refreshControl?.tintColor = UIColor.red
        
        refreshControl?.addTarget(self,
                                  action: #selector(UserMissionTableViewController.handleRefresh(refreshControl:)),
                                  for: UIControlEvents.valueChanged)
        
        //refreshControl?.addTarget(self, action: #selector(TableViewController.populate), for: UIControlEvents.valueChanged)
        
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        //1초의 딜레이를 준다..
        self.perform(#selector(self.endRefresh), with: nil, afterDelay: 1.0)
    }

    func endRefresh() {
        
        for i in 1...1000{
            testArray.append(i)
        }
        
        tableView.reloadData()
        
        refreshControl?.endRefreshing()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testArray.count
    }

    //UserMissionCellIdentifier
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = testArray[indexPath.row].description
        
        return cell
 
    }
    
    func viewForObserve() -> UIView{
        
        return self.tableView
    }
}
