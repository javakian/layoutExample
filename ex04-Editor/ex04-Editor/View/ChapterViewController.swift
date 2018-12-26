//  ChapterViewController.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/24/18.

import UIKit
import AVFoundation
import AVKit
import Layout
import Model

final class ChapterViewController: UIViewController, LayoutLoading, EditToolbarDelegate,
                                   UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet   var chapterCollectionView:  UICollectionView?
    @IBOutlet   var editToolbar:            EditToolbar?
                var chapter:                Chapter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(named:    "ChapterView.xml",
                   state:     StateManager.singleton.globalState,
                   constants: StateManager.singleton.globalLayoutConstants )
        self.navigationItem.title = self.chapter!.title
        if ( !StateManager.singleton.getStateBool( .isEditMode_Bool )) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                                     target: self,
                                                                     action: #selector(_playButtonPress(sender:)))
        }
        self.editToolbar?.toolbarSetup(controller: self, delegate: self )
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0 ) ? self.chapter!.aUniqueId.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetId     = self.chapter!.aUniqueId[ indexPath.row ]
        let contentIdx  = ContentIndex.singleton.getBy(itemId: assetId )!
        var node: LayoutNode? = nil
        switch contentIdx.itemContentType {
        case .image:
            let imageAsset = Image.getById( assetId )!
            node = self._imageAssetNodeCell(imageAsset, collectionView: collectionView, indexPath: indexPath )
        case .movie:
            let movieAsset = Movie.getById( assetId )!
            node = self._movieAssetNodeCell(movieAsset, collectionView: collectionView, indexPath: indexPath )
        case .text:
            let textAsset = Text.getById( assetId )!
            node = self._textAssetNodeCell(textAsset, collectionView: collectionView, indexPath: indexPath )
        default:
            preconditionFailure("unexpected ContentIndex: \(contentIdx)")
        }
        return node!.view as! UICollectionViewCell
    }
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assetId     = self.chapter!.aUniqueId[ indexPath.row ]
        self._showPlayView(assetIds: [ assetId ])
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
    private func _imageAssetNodeCell( _ imageAsset:   Image,
                                      collectionView: UICollectionView,
                                      indexPath:      IndexPath ) -> LayoutNode {
        let node  = collectionView.dequeueReusableCellNode(withIdentifier: "chapterImageCell", for: indexPath )
        let image = imageAsset.loadUIImage()
        node.setState([
            "image":    image
            ])
        return node
    }
    private func _movieAssetNodeCell( _ movieAsset:     Movie,
                                      collectionView:   UICollectionView,
                                      indexPath:        IndexPath ) -> LayoutNode {
        let node       = collectionView.dequeueReusableCellNode(withIdentifier: "chapterMovieCell", for: indexPath )
        let player     = movieAsset.loadAVPlayer()
        player.isMuted = true
        node.setState([
            "avPlayer":     player
            ])
        if ( !StateManager.singleton.getStateBool(.isEditMode_Bool)) {
            player.play()
        }
        return node
    }
    private func _textAssetNodeCell( _ textAsset:     Text,
                                     collectionView: UICollectionView,
                                     indexPath:      IndexPath ) -> LayoutNode {
        let node  = collectionView.dequeueReusableCellNode(withIdentifier: "chapterTextCell", for: indexPath )
        node.setState([
            "cellText": textAsset.aPara[0].getSummary()
            ])
        return node
    }
    @objc private func _playButtonPress( sender: UIBarButtonItem ) {
        self._showPlayView(assetIds: self.chapter!.aUniqueId )
    }
    private func _showPlayView( assetIds: [Int] ) {
        let playVC   = PlayViewController()
        playVC.aAssetId = assetIds 
        self.navigationController?.pushViewController( playVC, animated: true )
    }
}
