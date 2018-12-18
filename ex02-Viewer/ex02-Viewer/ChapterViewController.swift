//  ChapterViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import AVFoundation
import AVKit
import Layout
import Model

final class ChapterViewController: UIViewController, LayoutLoading,
                                   UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet   var chapterCollectionView:  UICollectionView?
                let chapter:                Chapter
    
    internal init( chapterId: Int ) {
        self.chapter = Chapter.getById( chapterId )!
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(named:    "ChapterView.xml",
                   constants: [String: Any]())
        self.navigationItem.title = self.chapter.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                                 target: self,
                                                                 action: #selector(_playButtonPress(sender:)))
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0 ) ? self.chapter.aUniqueId.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetId     = self.chapter.aUniqueId[ indexPath.row ]
        var node: LayoutNode? = nil
        repeat {
            if let imageAsset = Image.getById( assetId ) {
                node = self._imageAssetNodeCell(imageAsset, collectionView: collectionView, indexPath: indexPath )
                break
            }
            if let movieAsset = Movie.getById( assetId ) {
                node = self._movieAssetNodeCell(movieAsset, collectionView: collectionView, indexPath: indexPath )
                break
            }
            if let textAsset = Text.getById( assetId ) {
                node = self._textAssetNodeCell(textAsset, collectionView: collectionView, indexPath: indexPath )
                break
            }
        } while( false )
        return node!.view as! UICollectionViewCell
    }
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assetId     = self.chapter.aUniqueId[ indexPath.row ]
        self._showPlayView(assetIds: [ assetId ])
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
        player.play()
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
        self._showPlayView(assetIds: self.chapter.aUniqueId )
    }
    private func _showPlayView( assetIds: [Int] ) {
        let playVC   = PlayViewController(assetIds: assetIds )
        self.navigationController?.pushViewController( playVC, animated: true )
    }
}
