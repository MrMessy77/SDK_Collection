//
//  BaiduMapController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/21.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 百度地图
class BaiduMapController: UIViewController, UITableViewDelegate, UITableViewDataSource, BMKGeneralDelegate {

    var tableView: UITableView!
    let viewControls = [BaiduMapLocationViewController(), //定位
        BaiduMapViewController() //地图
    ]
    let viewControlsTitles = ["定位",
                              "地图"
    ]
    var _mapManager: BMKMapManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        //要使用百度地图，请先启动BaiduMapManager
        _mapManager = BMKMapManager()
        //如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("TzxZWH6M752GGX2of7XvmwRK1vUtU1aZ", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
        
        tableView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHight - 64))
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewControlsTitles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        viewControls[indexPath.row].title = viewControlsTitles[indexPath.row]
        self.navigationController?.pushViewController(viewControls[indexPath.row], animated: true)
    }
    
    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }
    //
}
