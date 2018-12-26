//  PlayViewController.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/24/18.

import UIKit
import AVFoundation
import AVKit
import Layout
import Model

final class PlayViewController: UIViewController, LayoutLoading, EditToolbarDelegate {
    @IBOutlet       var     editToolbar:    EditToolbar? 
    @IBOutlet       var     imageView:      UIImageView?
    @IBOutlet       var     movieView:      UIView?
    @IBOutlet       var     textView:       UILabel?
    @IBOutlet       var     captionView:    UILabel?
    @IBOutlet       var     avController:   AVPlayerViewController?
    internal        var     aAssetId:       [Int]  = [Int]()
                    var     curAssetIndex:  Int    = 0
                    var     curTimer:       Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var mergedState = StateManager.singleton.globalState
        mergedState.merge( self._viewState ) { (current,_) in current }
        loadLayout(named:    "PlayView.xml",
                   state:    mergedState,
                   constants: StateManager.singleton.globalLayoutConstants,
                               ["labelHeight" : 44 ])
        if let toolbar = self.editToolbar {
            toolbar.toolbarSetup(controller: self, delegate: self )
            toolbar.items = [toolbar.barItemDelete, toolbar.barItemSpace, toolbar.barItemEdit,
                             toolbar.barItemSpace, toolbar.barItemMove]
        }
        self._showCurrentAsset()
    }
    // MARK: private - visible view
    private enum _stateValues: String {
        case captionHidden = "captionHidden"
        case imageHidden   = "imageHidden"
        case movieHidden   = "movieHidden"
        case textHidden    = "textHidden"
    }
    private var  _viewState: [String: Bool] = [
        _stateValues.captionHidden.rawValue: false,
        _stateValues.imageHidden.rawValue:   false,
        _stateValues.movieHidden.rawValue:   true,
        _stateValues.textHidden.rawValue:    true
    ]
    private func _setVisibleView( _ view_: UIView ) {
        if view_ == self.imageView! {
            self._updateViewState(image: false, movie: true, text: true, caption: false )
            return
        }
        if view_ == self.movieView! {
            self._updateViewState(image: true, movie: false, text: true, caption: false )
            return
        }
        if view_ == self.textView! {
            self._updateViewState(image: true, movie: true, text: false, caption: true )
            return
        }
    }
    private func _updateViewState( image: Bool, movie: Bool, text: Bool, caption: Bool ) {
        var didChange = false
        if ( _viewState[ _stateValues.imageHidden.rawValue ] != image ) {
            _viewState[ _stateValues.imageHidden.rawValue ] = image
            didChange = true
        }
        if ( _viewState[ _stateValues.movieHidden.rawValue ] != movie ) {
            _viewState[ _stateValues.movieHidden.rawValue ] = movie
            didChange = true
        }
        if ( _viewState[ _stateValues.textHidden.rawValue ] != text ) {
            _viewState[ _stateValues.textHidden.rawValue ] = text
            didChange = true
        }
        if ( _viewState[ _stateValues.captionHidden.rawValue ] != caption ) {
            _viewState[ _stateValues.captionHidden.rawValue ] = caption
            didChange = true
        }
        if ( didChange ) {
            self.layoutNode?.setState( self._viewState )
        }
    }
    private func _showCurrentAsset() -> Void {
        let assetId = self.aAssetId[ self.curAssetIndex ]
        let contentIdx = ContentIndex.singleton.getBy(itemId: assetId )!
        switch contentIdx.itemContentType {
        case .image:
            self._showImageAsset( Image.getById( contentIdx.itemUniqueId)! )
        case .movie:
            self._showMovieAsset( Movie.getById( contentIdx.itemUniqueId)! )
        case .text:
            self._showTextAsset(  Text.getById( contentIdx.itemUniqueId )! )
        default:
            preconditionFailure("invalid ContentIndex: \(contentIdx)")
        }
     }
    private func _showImageAsset( _ imageAsset: Image ) -> Void {
        self._setVisibleView( imageView! )
        captionView?.text = imageAsset.caption
        imageView?.image = imageAsset.loadUIImage()
        self._launchTimer(seconds: 5.0 )
    }
    private func _showMovieAsset( _ movieAsset: Movie ) -> Void {
        self._setVisibleView( movieView! )
        captionView?.text = movieAsset.caption
        let player     = movieAsset.loadAVPlayer()
        player.isMuted = false
        self.avController?.player = player
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(_movieFinished),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil )
        if ( !StateManager.singleton.getStateBool(.isEditMode_Bool)) {
            player.play()
        }
    }
    private func _showTextAsset( _ textAsset: Text ) -> Void {
        let htmlBuilder = HtmlBuilder()
        textAsset.addToBuilder( htmlBuilder )
        htmlBuilder.finish()
        let htmlData = htmlBuilder.product()
        let htmlOpts = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html ]
        let attribString =  try! NSAttributedString(data:    htmlData,
                                                    options: htmlOpts,
                                                    documentAttributes: nil )
        self.textView?.attributedText = attribString
        self._setVisibleView( textView! )
        self._launchTimer(seconds: 6.0 )
    }
    private func _launchTimer( seconds: TimeInterval ) -> Void {
        if ( self.curTimer?.isValid == true ) {
            self.curTimer?.invalidate()
            self.curTimer = nil
        }
        self.curTimer = Timer(timeInterval: seconds,
                              target: self, selector: #selector(fireTimer(timer:)),
                              userInfo: nil, repeats: false )
        RunLoop.current.add(self.curTimer!, forMode: .common )
    }
    private func _showNextAssetIfAvailable() {
        if ( self.curAssetIndex + 1 < self.aAssetId.count ) {
            self.curAssetIndex += 1
            DispatchQueue.main.async {
                self._showCurrentAsset()
            }
        }
    }
    @objc private func fireTimer( timer: Timer ) -> Void {
        self.curTimer?.invalidate()
        self.curTimer = nil
        self._showNextAssetIfAvailable()
    }
    @objc private func _movieFinished() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                  object: nil )
        self._showNextAssetIfAvailable()
    }
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        preconditionFailure("invalid - add")
    }
    
    func deleteAction(toolbar: UIToolbar) {
        print("delete")
    }
    
    func editAction(toolbar: UIToolbar) {
        print("edit")
    }
    
    func reorderAction(toolbar: UIToolbar) {
        preconditionFailure("invalid - reorder")
    }
    
    func moveAction(toolbar: UIToolbar) {
        print("move")
    }
}
