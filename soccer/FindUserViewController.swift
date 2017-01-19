//
//  FindUserViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 17..
//  Copyright © 2017년 심성보. All rights reserved.
// 레이아웃 상에서 콜렉션 뷰를 마우스 오른쪽으로 view 컨트롤러에 딜리케이트 연결

import UIKit

//private let reuseIdentifier = "Cell"

class FindUserViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var findItem: UITextField!
    @IBOutlet weak var seletedItem: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func findAction(_ sender: Any) {
        print("버튼 클릭 \(self.seletedItem.selectedSegmentIndex)")
    }
    
    @IBAction func selectedItemAction(_ sender: Any) {
        print("선택 \(self.seletedItem.selectedSegmentIndex)")
    }
    
    @IBAction func textDismiss(_ sender: Any) {
        findItem.resignFirstResponder()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FindCollectionViewCell
        
        cell.level.text = "11"
        cell.name.text = "심성보"
        
        //cell.userImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row)")
    }
    
    //통신 펑션....추가
    //레이아웃 2개 고정
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let nbCol = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right+ (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        
        return CGSize(width: size, height: size)
        
    }
    
    
}
