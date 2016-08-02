//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Erick Manrique on 7/30/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
