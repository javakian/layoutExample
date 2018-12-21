//  LongTouchTip.swift
//  Interface
//
//  Created by CHH51 on 12/21/18.

import UIKit

final public class LongTouchTip {
    
    final fileprivate class TipTarget: EasyTipViewDelegate {
        let targetBarItem:  UIBarItem?
        let targetView:     UIView?
        let text:           String
        let durationSec:    Int
        var tipView:        EasyTipView? = nil
        var timer:          Timer? = nil
        
        fileprivate init( item: UIBarItem, text: String, durationSec: Int ) {
            self.targetBarItem  = item
            self.targetView     = nil
            self.text           = text
            self.durationSec    = durationSec
        }
        fileprivate init( view: UIView, text: String, durationSec: Int ) {
            self.targetBarItem  = nil
            self.targetView     = view
            self.text           = text
            self.durationSec    = durationSec
        }
        public func show( useDuration: Bool ) {
            if ( tipView == nil ) {
                tipView = EasyTipView(text: self.text, preferences: LongTouchTip.tipViewPreferences, delegate: self )
                if let barItem = self.targetBarItem {
                    tipView?.show(forItem: barItem )
                }
                if let view = self.targetView {
                    tipView?.show(forView: view )
                }
                if ( useDuration ) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(self.durationSec) ) {
                        self.tipView?.dismiss()
                    }
                }
            }
        }
        // MARK: EasyTipViewDelegate
        public func easyTipViewDidDismiss(_ tipView_: EasyTipView) {
            if ( self.tipView == tipView_ ) {
                if ( self.timer != nil ) {
                    self.timer = nil
                }
                self.tipView = nil
            }
        }
    }
    
    private(set) weak var targetView:       UIView?
    private           var _gesture:         UILongPressGestureRecognizer? = nil
    private           var _tipTargets       = [TipTarget]()
    
    public      init( view:     UIView ) {
        self.targetView     = view
        self._gesture       = UILongPressGestureRecognizer(target: self, action: #selector( _touchGestureMethod(_:) ) )
        self.targetView!.addGestureRecognizer( self._gesture! )
        self._gesture!.minimumPressDuration     = TimeInterval( 0.5 )
        self._gesture!.numberOfTapsRequired     = 0
        self._gesture!.numberOfTouchesRequired  = 1
    }
    public func addTipTarget( barItem: UIBarItem, text: String, durationSec: Int ) {
        self._tipTargets.append( TipTarget(item: barItem, text: text, durationSec: durationSec ))
    }
    public func addTipTarget( view: UIView, text: String, durationSec: Int ) {
        self._tipTargets.append( TipTarget(view: view, text: text, durationSec: durationSec ))
    }
    public func show() {
        for tipTarget in self._tipTargets {
            tipTarget.show(useDuration: true )
        }
    }
    // MARK: private
    @objc private func _touchGestureMethod( _ sender_: UIGestureRecognizer ) {
        self.show() 
    }
    // MARK: static - allow EasyTipView.Preferences to be modified
    private static var _tipViewPreferences = EasyTipView.Preferences()
    private static var _tipViewInitDone    = false
    public  static var  tipViewPreferences: EasyTipView.Preferences { get {
        if ( !_tipViewInitDone ) {
            _tipViewInitDone = true
            _tipViewPreferences.dismissWhenTouchingOutside  = true
            _tipViewPreferences.drawing.font                = UIFont.preferredFont(forTextStyle: .body )
            _tipViewPreferences.drawing.foregroundColor     = UIColor.white
            _tipViewPreferences.drawing.backgroundColor     = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        }
        return _tipViewPreferences
    } }
}
