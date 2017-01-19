//
//  SearchViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 13..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class SearchViewController: SJSegmentedViewController{
    
    var selectedSegment: SJSegmentTab?
    
    override func viewDidLoad() {
        
        if let storyboard = self.storyboard {
            
            let headerController = storyboard .instantiateViewController(withIdentifier: "headerdummy")
            
            let rankingTableViewController = storyboard
                .instantiateViewController(withIdentifier: "RankingTableViewController")
            rankingTableViewController.title = "랭킹정보"
            
            let findUserViewController = storyboard
                .instantiateViewController(withIdentifier: "FindUserViewController")
            findUserViewController.title = "찾기"
            
            
            
            headerViewController = headerController
            segmentControllers = [rankingTableViewController,
                                  findUserViewController]
            
            headerViewHeight = 200 //헤더의 뷰의 크기
            headerViewOffsetHeight = 20
            
            selectedSegmentViewHeight = 2.5 //밑줄바의 두께
            segmentTitleColor = .gray
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            delegate = self
        }
        
        super.viewDidLoad()

    }
}

extension SearchViewController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            //selectedSegment?.backgroundColor = UIColor.lightGray
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            //selectedSegment?.backgroundColor = UIColor.red
        }
    }
}
