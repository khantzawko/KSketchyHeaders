//
//  ViewController.swift
//  KSketchyHeaders
//
//  Created by Khant Zaw Ko on 9/5/16.
//  Copyright © 2016 Khant Zaw Ko. All rights reserved.
//

import UIKit

private let kTableViewHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 70.0

class ViewController: UITableViewController {
    
    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!
    
    let items = [
        NewsItem(category: .World, summary: "Climate change protests, diverstments meet fossil fuels realities"),
        NewsItem(category: .Europe, summary: "Scotland’s ‘Yes’ leader says independence vote is ‘once in a lifetime’"),
        NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .Americas, summary: "Officials FBI is tracking 100 Americas who fought alongside IS in Syria"),
        NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .Europe, summary: "One million babies’ created by EU student exchanges")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        let effectiveHeight = kTableViewHeaderHeight - kTableHeaderCutAway / 2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableViewHeaderHeight - kTableHeaderCutAway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableViewHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway / 2
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height - kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsItemCell
        cell.newsItem = item
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

