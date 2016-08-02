//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Erick Manrique on 7/14/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName:String
    
    init(name:SettingName, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel & Dismiss Completely"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
//    let settings: [Setting] = {
//        return [Setting(name: "Settings", imageName: "settings"), Setting(name: "Terms & privacy policy", imageName: "privacy"), Setting(name: "Send Feedback", imageName: "feedback"), Setting(name: "Help", imageName: "help"), Setting(name: "Switch Account", imageName: "switch_account"), Setting(name: "Cancel", imageName: "cancel")]
//    }()
    //enum version
    let settings: [Setting] = {
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        return [settingsSetting, Setting(name: .TermsPrivacy, imageName: "privacy"), Setting(name: .SendFeedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .SwitchAccount, imageName: "switch_account"), cancelSetting]
    }()
    
    var homeController: HomeController?
    
    func showSettings(){
        if let window = UIApplication.sharedApplication().keyWindow{
            //            let blackView = UIView()
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
//            let height:CGFloat = 200
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            
            let y = window.frame.height - height
            collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            blackView.frame = window.frame
            //            view.addSubview(blackView)
            //            blackView.frame = view.frame
            blackView.alpha = 0
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
                }, completion: nil)
            
//            UIView.animateWithDuration(0.5, animations: {
//                self.blackView.alpha = 1
//                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
//            })
        }
        
    }
    
    func handleDismiss(setting: Setting){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.sharedApplication().keyWindow {
                self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
            }
        }) { (completed) in
            print("completed")
            print(setting.name)
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting)
            }
        }
//        UIView.animateWithDuration(0.5) {
//            self.blackView.alpha = 0
//            if let window = UIApplication.sharedApplication().keyWindow {
//                self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
//            }
//        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print(setting.name)
        
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
        
//        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
//                self.blackView.alpha = 0
//                if let window = UIApplication.sharedApplication().keyWindow {
//                    self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
//                }
//            }) { (completed) in
//                print("completed")
//                let setting = self.settings[indexPath.item]
//                if setting.name != "Cancel"{
//                    self.homeController?.showControllerForSetting(setting)
//                }
//        }
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}






