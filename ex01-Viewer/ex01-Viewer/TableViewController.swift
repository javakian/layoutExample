//
//  TableViewController.swift
//  ex01-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import layout
import model

class TableViewController: UIViewController, LayoutLoading, UITableViewDataSource  {
    var tableView:  UITableView?
    var storyIds:   [Int]          = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyIds = Story.storyIds()
        
        loadLayout(named: "TableView.xml",
                   constants: [String: Any]() )
    }
    
    // MARK: LayoutLoading
    func layoutDidLoad(_ layoutNode_: LayoutNode) {
        self.tableView             = layoutNode_.view as? UITableView 
        self.tableView!.dataSource = self
     }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( section == 0 ) ? self.storyIds.count : 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node    = tableView.dequeueReusableCellNode(withIdentifier: "templateCell", for: indexPath )
        let storyId = storyIds[ indexPath.row ]
        let story   = Story.getById( storyId )!
        let summary = ContentSummary(storyId: storyId )
        let title   = story.label
        let image   = story.storyImage()
        let detail  = "\(summary.countImage) 🌃 \(summary.countMovie) 📽 \(summary.countText) 📖"
        node.setState([
            "rowTitle":  title,
            "rowDetail": detail,
            "image":     image
        ])
        return node.view as! UITableViewCell
    }

}

