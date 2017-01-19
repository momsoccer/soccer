//
//  SegmentViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class SegmentViewController: SJSegmentedViewController {
    
    var selectedSegment: SJSegmentTab?
    
    override func viewDidLoad() {
        if let storyboard = self.storyboard {
            
            let headerController = storyboard .instantiateViewController(withIdentifier: "headerdummy")
            
            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "UserMissionTableViewController")
            firstViewController.title = "유저미션"
            
            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "TeamBoardTableViewController")
            secondViewController.title = "팀게시판"
            
            let thirdViewController = storyboard
                .instantiateViewController(withIdentifier: "FriendTableViewController")
            thirdViewController.title = "친구관리"
            
            
            headerViewController = headerController
            segmentControllers = [firstViewController,
                                  secondViewController,
                                  thirdViewController]
            
            headerViewOffsetHeight = 20 //스크롤 후 상단과 하단의 간격
            headerViewHeight = 200 //헤더의 뷰의 크기
            
            selectedSegmentViewHeight = 2.5 //밑줄바의 두께
            segmentTitleColor = .gray
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            delegate = self
        }
        
        //title = "Segment" //하단 툴바 제목이 변경됨
        super.viewDidLoad()
    }
}

extension SegmentViewController: SJSegmentedViewControllerDelegate {
    
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
