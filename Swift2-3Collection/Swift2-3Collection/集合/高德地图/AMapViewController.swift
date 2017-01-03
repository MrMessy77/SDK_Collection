//
//  AMapViewController.swift
//  SwiftCollection
//
//  Created by MrMessy on 16/9/20.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

//MARK: - 高德地图
class AMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var viewControls = [AMapLocationViewController(), //定位
                        MAMapViewController() //地图
    ]
    let viewControlsTitles = ["定位",
                              "地图"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        AMapServices.sharedServices().apiKey = "31068c2580ecad28627e0c3216285e95"
        
        tableView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHight - 64))
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControlsTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewControlsTitles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let viewControl = viewControls[indexPath.row]
        viewControl.title = viewControlsTitles[indexPath.row]
        self.navigationController?.pushViewController(viewControl, animated: true)
    }
}
