//  StoryViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import Layout
import Model

class StoryViewController: UIViewController, LayoutLoading,
                           UITableViewDataSource, UITableViewDelegate, TableViewLayout {
    @IBOutlet   var storyTableView: UITableView? {
                    didSet { if let view = self.storyTableView {
                                self.registerTableCells(tableView: view ) }
                    }
                }
                let story:   Story
    
    internal init( storyId: Int ) {
        self.story   = Story.getById( storyId )!
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLayout(named:    "StoryView.xml",
                   constants: [
                    "navBarBottom": self.navigationController!.navigationBar.bounds.height
            ] )
        self.navigationItem.title = self.story.label
    }
    
    
    // MARK: UITableViewDataSource
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( section == 0 ) ? self.story.aChapterId.count : 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLarge   = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        let cellName  = isLarge ? "tableCellLarge" : "tableCellStandard"
        let node      = tableView.dequeueReusableCellNode(withIdentifier: cellName, for: indexPath )
        let chapterId = self.story.aChapterId[ indexPath.row ]
        let chapter   = Chapter.getById( chapterId )!
        let summary   = ContentSummary( chapterId: chapterId)
        let title     = chapter.title
        let image     = chapter.chapterImage()
        let detail    = "\(summary.countImage) 🌃 \(summary.countMovie) 📽 \(summary.countText) 📖"
        node.setState([
            "rowTitle":  title,
            "rowDetail": detail,
            "image":     image,
            "hideImage": isLarge

            ])
        return node.view as! UITableViewCell
    }
    // MARK: UITableViewDelegate
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let factor = CGFloat( self.rowHeightFactor(view: tableView ) )
        return tableView.estimatedRowHeight * factor
    }
}

