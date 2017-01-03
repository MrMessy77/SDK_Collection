//
//  AMapLocationViewController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/20.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 高德定位功能
class AMapLocationViewController: UIViewController, AMapServiceDelegate {

    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        self.showLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        AMapManager.singleton.oneLocation()
        AMapManager.singleton.delegate = self
    }
    
    func showLocation() {
        label = UILabel(frame: CGRectMake(0,64,view.bounds.width,view.bounds.height-64))
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 0
        view.addSubview(label)
    }
    
    //MARK: - AMapServiceDelegate
    func getReGeocode(reGeocode: String?) {
        if label.text != nil {
            label.text = label.text! + "\n逆地理编码：\(reGeocode!)"
        }else {
            label.text = "逆地理编码：\(reGeocode!)"
        }
    }
}
