//
//  BaiduMapLocationViewController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/21.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 高德地图定位
class BaiduMapLocationViewController: UIViewController, BDMapServiceDelegate {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        self.showLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        BaiduMapManager.singleton.startLocationService()
        BaiduMapManager.singleton.delegate = self
    }
    
    func showLocation() {
        label = UILabel(frame: view.bounds)
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 0
        view.addSubview(label)
    }
    
    func getLocationCity(city: String?) {
        if label.text != nil {
            label.text = label.text! + "\n定位城市：\(city!)"
        }else {
            label.text = "定位城市：\(city!)"
        }
    }
    
    func getLocationAddress(address: String?) {
        if label.text != nil {
            label.text = label.text! + "\n定位详细地址：\(address!)"
        }else {
            label.text = "定位详细地址：\(address!)"
        }
    }
}
