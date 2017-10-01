//
//  ViewController.swift
//  KSketchyHeaders
//
//  Created by Khant Zaw Ko on 9/5/16.
//  Copyright © 2016 Khant Zaw Ko. All rights reserved.
//

import UIKit

private let kTableViewHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 45.0

class ViewController: UITableViewController, UIWebViewDelegate {
    
    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!
    //var webView: UIWebView!
    
    var content : [String] = ["<style> .date {color: dimgrey;} body {margin-left: 10px; margin-right: 10px; font-family: Zawgyi-One; font-size: 18px;}</style> <body> <p> Late at night last week, <br> I heard Luis Suarez talking about the power of Barcelona's destruction of Celtic not solely being valuable for the three points or dominant goal difference in their group. No. The Uruguayan was clear that the intensity, electricity and efficiency were markers for their entire season because, in his words, Barcelona couldn't afford to drop even a single point more in La Liga. Late at night last week, I heard Luis Suarez talking about the power of Barcelona's destruction of Celtic not solely being valuable for the three points or dominant goal difference in their group. No. The Uruguayan was clear that the intensity, electricity and efficiency were markers for their entire season because, in his words, Barcelona couldn't afford to drop even a single point more in La Liga. </p> </body>", "test22<br>test22<br>test22<br>test22<br>test22<br>test22"]
    var contentHeights : [CGFloat] = [0.0, 0.0]

    let items = [
        NewsItem(category: .worldcup, summary: "Climate change protests, diverstments meet fossil fuels realities"),
        NewsItem(category: .bpl, summary: "Scotland’s ‘Yes’ leader says independence vote is ‘once in a lifetime’"),
        NewsItem(category: .seriesa, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .europaleague, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .championleague, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .asiacup, summary: "Officials FBI is tracking 100 Americas who fought alongside IS in Syria"),
        NewsItem(category: .mnl, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .championleague, summary: "One million babies’ created by EU student exchanges")
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
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        //tableView.reloadData()

        
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
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contentHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewsTableViewCell
        
        let htmlString = content[indexPath.row]
        _ = contentHeights[indexPath.row]
        
        cell.webView.tag = indexPath.row
        cell.webView.delegate = self
        cell.webView.loadHTMLString(htmlString, baseURL: nil)
        cell.webView.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        
        cell.backgroundView = cell.webView
        
        print()

        return cell
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        if contentHeights[webView.tag] == webView.scrollView.contentSize.height {
            return
        }

        
        contentHeights[webView.tag] = webView.scrollView.contentSize.height
        
        print(webView.tag)
        
        let index = NSIndexPath(row: webView.tag, section: 0)
        tableView.reloadRows(at: [index as IndexPath], with: .automatic)
        //tableView.reloadRows(at: [NSIndexPath(item: index, section: 0) as IndexPath] , with: .automatic)
        
        
        print(webView.scrollView.contentSize.height)
        //tableView.reloadRows(at: [index as IndexPath], with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }  
    }

}

