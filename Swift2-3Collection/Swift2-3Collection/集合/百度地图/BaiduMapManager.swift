//
//  BaiduMapManager.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/21.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

@objc protocol BDMapServiceDelegate {
    optional func getLocationCity(city: String?)
    optional func getLocationAddress(address: String?)
}

//MARK: - 百度地图管理类
class BaiduMapManager: NSObject, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate {
    
    static let singleton = BaiduMapManager() //单例
    var delegate: BDMapServiceDelegate?
    var locationService: BMKLocationService! //百度定位服务
    var geocodeSearch: BMKGeoCodeSearch! //百度编码
    
    //MARK: - 开启定位功能
    func startLocationService() {
        locationService = BMKLocationService()
        locationService.delegate = self
        locationService.startUserLocationService()
        
        geocodeSearch = BMKGeoCodeSearch()
        geocodeSearch.delegate = self
    }
    
    //MARK: - BMKLocationServiceDelegate
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
    }
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        let longitude = userLocation.location.coordinate.longitude //经度
        let latitude = userLocation.location.coordinate.latitude //纬度
        print("lon:\(longitude),lat:\(latitude)")
        
        //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        locationService.stopUserLocationService()
        locationService.delegate = nil
        
        let reverseGeocodeSearchOption = BMKReverseGeoCodeOption()
        reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(latitude, longitude)
        let flag = geocodeSearch.reverseGeoCode(reverseGeocodeSearchOption)
        if flag {
            print("反geo 检索发送成功")
        } else {
            print("反geo 检索发送失败")
        }
    }
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
    
    //MARK: - BMKGeoCodeSearchDelegate
    /**
     *返回反地理编码搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            self.delegate?.getLocationCity?(result.addressDetail.city)
            self.delegate?.getLocationAddress?(result.address)
            geocodeSearch.delegate = nil
        }
    }
}
