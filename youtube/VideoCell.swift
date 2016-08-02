//
//  VideoCell.swift
//  youtube
//
//  Created by Erick Manrique on 7/6/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
//            thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            setupThumbnailImage()
            setupProfileImage()
            
//            if let profileImageName = video?.channel?.profileImageName {
//                print(profileImageName)
//                userProfileImageView.image = UIImage(named: profileImageName)
//            }
            
            if let channelName = video?.channel?.name, numberOfViews = video?.number_of_views {
                
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subtitleText = "\(channelName) • \(numberFormatter.stringFromNumber(numberOfViews)!) • 2 years ago "
                subtitleTextView.text = subtitleText
            }
            //measure title text
            if let title = video?.title {
                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                if estimateRect.size.height > 20 {
                    self.titleLabelHeightConstraint?.constant = 44
                }
                else{
                    self.titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(profileImageUrl)
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
//        if let thumbnailImageUrl = video?.thumbnailImageName {
////            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
////            print(thumbnailImageUrl)
//            let url = NSURL(string: thumbnailImageUrl)
//            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
//                if error != nil{
//                    print(error)
//                    return
//                }
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.thumbnailImageView.image = UIImage(data: data!)
//                })
//            }).resume()
//        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //        imageView.backgroundColor = UIColor.blueColor()
        //no longer needed becaus it in addConstraintsWithFormat
        //        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        //        imageView.backgroundColor = UIColor.greenColor()
        imageView.image = UIImage(named: "taylor_swift_profile")
        //radius needs to be half with (44) to be rounded image
        imageView.layer.cornerRadius = 22
        // this is needed if we want the image corner change to take affect
        imageView.layer.masksToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = UIColor.purpleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView:UITextView = {
        let textView = UITextView()
        //        textView.backgroundColor = UIColor.redColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbnailImageView]))
        
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbnailImageView, "v1":separatorView]))
        
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":separatorView]))
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":seperatorView]))
        //horizontal contraints
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        //        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        //titleLabel constraints
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        //subtitle textview constraints
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
    }
}