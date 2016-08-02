//
//  ViewController.swift
//  youtube
//
//  Created by Erick Manrique on 7/6/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//
//remeber to get rid of Main in the interface builder in the youtube blue folder on the left(where build setting are)

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 23932843093
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 57989654934
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()

//    var videos: [Video]?
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
//    func fetchVideos(){
//        
//        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
//            
//            self.videos = videos
//            self.collectionView?.reloadData()
//            
//        }
//        
////        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
////        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
////            if error != nil{
////                print(error)
////                return
////            }
////            do{
////                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
////                
////                self.videos = [Video]()
////                
////                for dictionary in json as! [[String:AnyObject]]{
////                    let video = Video()
////                    video.title = dictionary["title"] as? String
////                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
////                    
////                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
////                    
////                    let channel = Channel()
////                    channel.name = channelDictionary["name"] as? String
////                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
////                    
////                    video.channel = channel
////
////                    self.videos?.append(video)
//////                    print(dictionary["title"])
////                }
////                dispatch_async(dispatch_get_main_queue(), { 
////                    self.collectionView?.reloadData()
////                })
////                
//////                print(json)
////            }catch let jsonError{
////                print(jsonError)
////            }
////            
//////            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//////            print(str)
////        }.resume()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchVideos()
        
//        navigationItem.title = "Homes"
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0,0, view.frame.width-32, view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
//        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        
        
//        collectionView?.backgroundColor = UIColor.whiteColor()
//        //registers the cell with the identifier so we can use it in cellforitematindexpath
//        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
////        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        //need this bacuse collection view was under menubar it needs to be below
//        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
//        //this is so the scroll bar does not go under menu bar but rather below it
//        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.whiteColor()
        //registers the cell with the identifier so we can use it in cellforitematindexpath
//        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
//        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        //        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //need this bacuse collection view was under menubar it needs to be below
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        //this is so the scroll bar does not go under menu bar but rather below it
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.pagingEnabled = true

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("this is trig")
    }
    
    
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
//    let settingsLauncher = SettingsLauncher()
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    func handleMore(){
        settingsLauncher.showSettings()
        settingsLauncher.homeController = self
//        showControllerForSettings()
    }
    
    func showControllerForSetting(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.whiteColor()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    func handleSearch(){
        print(123)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        setTitleForIndex(menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    private func setupMenuBar(){
        //this is to hide navigatio bar when we swipe / scroll up
        navigationController?.hidesBarsOnSwipe = true
        // this is to prevent the swipe away of nave bar to show the white of the table view
        //basically this make swipe transition more fluid
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        //IOS 9 constraint fix for menu bar alwyas being on top but below navbar
//        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        
        //IOS 8 fix
        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))

    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.memory.x / view.frame.width
        
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        
        setTitleForIndex(Int(index))
    }
    
    // new collection view code included to support swipe feature
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
       
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCellWithReuseIdentifier(trendingCellId, forIndexPath: indexPath)
        }
        
//        let colors: [UIColor] = [.blueColor(), .greenColor(), UIColor.grayColor(), .purpleColor()]
//        
//        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    //old collection view code
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count{
//            return count
//        }
//        return 0
//        //IOS 9
////        return videos?.count ?? 0
//    }
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
//        cell.video = videos?[indexPath.item]
////        cell.thumbnailImageView.image = UIImage(named: "taylor_swift_blank_space")
//        
//        return cell
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        
////        objective c way
////        return CGSizeMake(view.frame.width, 200)
////        swift way
////        return CGSize(width: view.frame.width, height: 200)
//        return CGSize(width: view.frame.width, height: height + 16 + 44 + 8 + 36)
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 0
//    }
    
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
}