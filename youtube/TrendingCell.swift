//
//  TrendingCell.swift
//  youtube
//
//  Created by Erick Manrique on 7/29/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
