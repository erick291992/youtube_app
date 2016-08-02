//
//  FeedCell.swift
//  youtube
//
//  Created by Erick Manrique on 7/28/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]?
    let cellId = "cellId"
    
    func fetchVideos(){
        
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        backgroundColor = UIColor.brownColor()
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = videos?.count{
            return count
        }
        return 0
        //IOS 9
        //        return videos?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        //        cell.thumbnailImageView.image = UIImage(named: "taylor_swift_blank_space")
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        
        //        objective c way
        //        return CGSizeMake(view.frame.width, 200)
        //        swift way
        //        return CGSize(width: view.frame.width, height: 200)
        return CGSize(width: frame.width, height: height + 16 + 44 + 8 + 36)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

}
