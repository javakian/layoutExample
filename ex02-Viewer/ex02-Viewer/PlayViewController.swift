//  PlayViewController.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import AVFoundation
import AVKit
import Layout
import Model

final class PlayViewController: UIViewController, LayoutLoading {
    @IBOutlet       var     imageView:      UIImageView?
    @IBOutlet       var     captionLabel:   UILabel?
                    let     aAssetId:       [Int]
                    var     curAssetIndex:  Int
    
    internal init( assetIds: [Int] ) {
        self.aAssetId      = assetIds
        self.curAssetIndex = 0
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(named:    "PlayView.xml",
                   constants: [
                    "navBarBottom": self.navigationController!.navigationBar.bounds.height
            ] )
        self._showCurrentAsset()
    }
    // MARK: private
    private func _showCurrentAsset() -> Void {
        let assetId = self.aAssetId[ self.curAssetIndex ]
        if let imageAsset = Image.getById( assetId ) {
            self._showImageAsset( imageAsset )
            return
        }
        if let movieAsset = Movie.getById( assetId ) {
            self._showMovieAsset( movieAsset )
            return
        }
        if let textAsset = Text.getById( assetId ) {
            self._showTextAsset( textAsset )
        }
    }
    private func _showImageAsset( _ imageAsset: Image ) -> Void {
        captionLabel?.text = imageAsset.caption
        imageView?.image = imageAsset.loadUIImage()
    }
    private func _showMovieAsset( _ movieAsset: Movie ) -> Void {
        captionLabel?.text = movieAsset.caption
        let bear = Image.getById( eUId.phMOR_Bear.rawValue )!
        imageView?.image = bear.loadUIImage()
    }
    private func _showTextAsset( _ textAsset: Text ) -> Void {
        captionLabel?.text = textAsset.aPara[0].getSummary()
        let bear = Image.getById( eUId.phMOR_Bear.rawValue )!
        imageView?.image = bear.loadUIImage()

    }
}
