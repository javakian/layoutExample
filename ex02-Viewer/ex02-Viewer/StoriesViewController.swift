//  StoriesViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import Layout
import Model

class StoriesViewController: UIViewController, LayoutLoading, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet   var storiesTableView: UITableView?
                var storyIds          = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        storyIds = Story.storyIds()
        
        loadLayout(named:    "StoriesView.xml",
                   constants: [
                        "rowHeight":    50,
                        "navBarBottom": self.navigationController!.navigationBar.bounds.height
                              ] )
        self.navigationItem.title = "Stories"
    }


    // MARK: UITableViewDataSource
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( section == 0 ) ? self.storyIds.count : 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node    = tableView.dequeueReusableCellNode(withIdentifier: "storiesTemplateCell", for: indexPath )
        let storyId = storyIds[ indexPath.row ]
        let story   = Story.getById( storyId )!
        let summary = ContentSummary(storyId: storyId )
        let title   = story.label
        let image   = story.storyImage()
        let detail  = "\(summary.countImage) 🌃 \(summary.countMovie) 📽 \(summary.countText) 📖"
        node.setState([
            "rowTitle":     title,
            "rowDetail":    detail,
            "image":        image
             ])
        return node.view as! UITableViewCell
    }
    
    // MARK: UITableViewDelegate
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyId = self.storyIds[ indexPath.row ]
        let storyVC = StoryViewController(storyId: storyId )
        self.navigationController?.pushViewController( storyVC, animated: true )
    }
}

