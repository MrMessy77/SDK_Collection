//
//  BaiduMapViewController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/21.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 百度地图展示
class BaiduMapViewController: UIViewController, BMKMapViewDelegate, BMKLocationServiceDelegate {

    var mapView: BMKMapView!
    var locationService: BMKLocationService! //百度定位服务
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        locationService = BMKLocationService()
        locationService.delegate = self
        locationService.startUserLocationService()
        
        mapView = BMKMapView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHight - 64))
        mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        mapView.showsUserLocation = true//显示定位图层
        mapView.zoomLevel = 19
        view.addSubview(mapView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationService.delegate = self
        mapView.delegate = self
        locationService.delegate = self
        mapView.viewWillAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
        locationService.delegate = nil
        mapView.viewWillDisappear()
    }
    
    // MARK: - BMKMapViewDelegate
    
    // MARK: - BMKLocationServiceDelegate
    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser");
    }
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        print("heading is \(userLocation.heading)")
        mapView.updateLocationData(userLocation)
    }
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(userLocation: BMKUserLocation!) {
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        mapView.updateLocationData(userLocation)
    }
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
}
