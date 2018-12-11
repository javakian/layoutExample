//  StoryViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import Layout
import Model

class StoryViewController: UIViewController, LayoutLoading, UITableViewDataSource {
    @IBOutlet   var storyTableView: UITableView? 
                var storyIds        = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        storyIds = Story.storyIds()
        
        loadLayout(named:    "StoryView.xml",
                   constants: [String:Any]() )
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

