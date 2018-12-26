//  StoriesViewController.swift
//  ex04-Viewer
//
//  Created by CHH51 on 12/19/18.

import UIKit
import Layout
import Model
import Interface

final class StoriesViewController: UIViewController, LayoutLoading,
                                   UITableViewDataSource, UITableViewDelegate, TableViewLayout {
    @IBOutlet   var storiesTableView: UITableView?
    @IBOutlet   var storiesToolbar:   StoriesViewToolbar? {
                        didSet { if let toolbar = self.storiesToolbar {
                                    toolbar.toolbarSetup(controller: self ) }}}
                var storyIds          = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        storyIds = Story.storyIds()
        
        loadLayout(named:     "StoriesView.xml",
                   state:     StateManager.singleton.globalState, 
                   constants: StateManager.singleton.globalLayoutConstants )
        self.navigationItem.title = "Stories"
    }


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
        let storyId   = self.storyIds[ indexPath.row ]
        let storyVC   = StoryViewController()
        storyVC.story = Story.getById( storyId )
        self.navigationController?.pushViewController( storyVC, animated: true )
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let factor = CGFloat( self.rowHeightFactor(view: tableView ) )
        return tableView.estimatedRowHeight * factor
    }
}

