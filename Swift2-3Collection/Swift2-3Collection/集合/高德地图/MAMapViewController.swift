//
//  MAMapViewController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/20.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 高德地图展示
class MAMapViewController: UIViewController, MAMapViewDelegate {

    var mapView: MAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        ///初始化地图
        mapView = MAMapView(frame: CGRectMake(0, 64, screenWidth, screenHight - 64))
        mapView.userTrackingMode = MAUserTrackingMode.Follow //设置定位的状态
        mapView.showsUserLocation = true //YES 为打开定位，NO为关闭定位
        mapView.zoomLevel = 18.5
        
        ///把地图添加至view
        self.view.addSubview(mapView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
        
        self.mapView.mapType = MAMapType.Standard
    }
    
    //MARK: - MAMapViewDelegate
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
        
    }
}
