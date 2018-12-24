//  StoryViewController.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/22/18.

import UIKit
import Layout
import Model

final class StoryViewController: UIViewController, LayoutLoading, EditToolbarDelegate,
                                 UITableViewDataSource, UITableViewDelegate, TableViewLayout {
    @IBOutlet   var storyTableView: UITableView?
    @IBOutlet   var editToolbar:    EditToolbar?
                var story:          Story? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLayout(named:     "StoryView.xml",
                   state:     StateManager.singleton.globalState,
                   constants: StateManager.singleton.globalLayoutConstants )
        self.navigationItem.title = self.story!.label
        if ( !StateManager.singleton.getStateBool( .isEditMode_Bool )) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                                     target: self,
                                                                     action: #selector(_playButtonPress(sender:)))
        }
        self.editToolbar?.toolbarSetup(controller: self, delegate: self )
        self._updateToolbar()
    }
    
    // MARK: UITableViewDataSource
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( section == 0 ) ? self.story!.aChapterId.count : 0
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLarge   = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        let cellName  = isLarge ? "tableCellLarge" : "tableCellStandard"
        let node      = tableView.dequeueReusableCellNode(withIdentifier: cellName, for: indexPath )
        let chapterId = self.story!.aChapterId[ indexPath.row ]
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
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapterId = self.story!.aChapterId[ indexPath.row ]
        let chapterVC = ChapterViewController()
        chapterVC.chapter = Chapter.getById( chapterId )
        self.navigationController?.pushViewController( chapterVC, animated: true )
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let factor = CGFloat( self.rowHeightFactor(view: tableView ) )
        return tableView.estimatedRowHeight * factor
    }
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        print("add")
    }
    
    func deleteAction(toolbar: UIToolbar) {
        print("delete")
    }
    
    func editAction(toolbar: UIToolbar) {
        print("edit")
    }
    
    func reorderAction(toolbar: UIToolbar) {
        print("reorder")
    }
    
    func moveAction(toolbar: UIToolbar) {
        print("move")
    }
    
    // MARK: private
    @objc private func  _playButtonPress( sender: UIBarButtonItem ) {
        let playVC   = PlayViewController()
        playVC.aAssetId = self.story!.allContentId()
        self.navigationController?.pushViewController( playVC, animated: true )
    }
    private func        _updateToolbar() {
        self.editToolbar?.barItemReorder.isEnabled = ( self.story?.aChapterId.count ?? 0 ) > 1
    }
}
