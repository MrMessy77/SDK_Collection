//
//  AMapManager.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/20.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

@objc protocol AMapServiceDelegate {
    optional func getReGeocode(reGeocode: String?) //获取逆地理编码信息
}

//MARK: - 高德地图管理类
class AMapManager: NSObject, AMapLocationManagerDelegate {
    
    static let singleton = AMapManager() //单例
    var delegate: AMapServiceDelegate?
    var locationManager: AMapLocationManager!
    
    //MARK: - 开启定位功能
    func startLocation() {
        locationManager = AMapLocationManager()
        locationManager.delegate = self
    }
    
    //MARK: - 持续定位
    func continueLocation() {
        self.startLocation()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - 单次定位
    func oneLocation() {
        self.startLocation()
        locationManager.delegate = nil
        
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // 定位超时时间，最低2s，此处设置为2s
        locationManager.locationTimeout = 10
        // 逆地理请求超时时间，最低2s，此处设置为2s
        locationManager.reGeocodeTimeout = 10
        
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO，则不会返回地址信息。
        locationManager.requestLocationWithReGeocode(true) { (location, regeocode, error) in
            if (error != nil) {
                print("locError:{\(error.code) - \(error.localizedDescription)}")
                    if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return
                }
            }
            if (regeocode != nil) {
                print("reGeocode:\(regeocode)")
                self.delegate?.getReGeocode?("reGeocode:\(regeocode!)")
            }
        }
    }
    
    //MARK: - AMapLocationManagerDelegate
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)")
        locationManager.stopUpdatingLocation()
    }
}
