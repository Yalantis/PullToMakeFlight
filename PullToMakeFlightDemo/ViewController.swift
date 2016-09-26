//
//  ViewController.swift
//  PullToMakeFlightDemo
//
//  Created by Anastasiya Gorban on 5/27/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

import UIKit
import PullToMakeFlight

class ViewController: UITableViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.separatorStyle = .none
        
        tableView.addPullToRefresh(PullToMakeFlight(at: .top)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
                self.tableView.endRefreshing(at: .top)
            }
        }
    }
    
    @IBAction fileprivate func refresh() {
        tableView.startRefreshing(at: .top)
    }
}

