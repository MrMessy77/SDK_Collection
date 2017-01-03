//
//  ViewController.swift
//  Swift2-3Collection
//
//  Created by MrMessy on 16/9/22.
//  Copyright © 2016年 MrMessy. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.width
let screenHight = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let viewControls = [AMapViewController(), //高德地图
        BaiduMapController() //百度地图
    ]
    let viewControlsTitles = ["高德地图",
                              "百度地图"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "集合"
        automaticallyAdjustsScrollViewInsets = false
        
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
}

