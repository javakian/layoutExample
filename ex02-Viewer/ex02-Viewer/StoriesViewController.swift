//  StoriesViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import Layout
import Model

final class StoriesViewController: UIViewController, LayoutLoading,
                                   UITableViewDataSource, UITableViewDelegate, TableViewLayout {
    @IBOutlet   var storiesTableView: UITableView? {
                    didSet { if let view = self.storiesTableView {
                                self.registerTableCells(tableView: view ) }
                    }
                }
                var storyIds          = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        storyIds = Story.storyIds()
        
        loadLayout(named:     "StoriesView.xml",
                   constants: StoriesViewController.globalLayoutConstants )
        self.navigationItem.title = "Stories"
    }
    // MARK: static
    public static let globalLayoutConstants: [String: Any] = [
        "backgrndColor"     : UIColor.lightGray
    ]


    // MARK: UITableViewDataSource
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( section == 0 ) ? self.storyIds.count : 0
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLarge  = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        let cellName = isLarge ? "tableCellLarge" : "tableCellStandard"
        let node     = tableView.dequeueReusableCellNode(withIdentifier: cellName, for: indexPath )
        let storyId  = storyIds[ indexPath.row ]
        let story    = Story.getById( storyId )!
        let summary  = ContentSummary(storyId: storyId )
        let title    = story.label
        let image    = story.storyImage()
        let detail   = "\(summary.countImage) 🌃 \(summary.countMovie) 📽 \(summary.countText) 📖"
        node.setState([
            "rowTitle":   title,
            "rowDetail":  detail,
            "image":      image,
            "hideImage":  isLarge
             ])
        return node.view as! UITableViewCell
    }
    
    // MARK: UITableViewDelegate
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyId = self.storyIds[ indexPath.row ]
        let storyVC = StoryViewController(storyId: storyId )
        self.navigationController?.pushViewController( storyVC, animated: true )
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let factor = CGFloat( self.rowHeightFactor(view: tableView ) )
        return tableView.estimatedRowHeight * factor
     }
}

