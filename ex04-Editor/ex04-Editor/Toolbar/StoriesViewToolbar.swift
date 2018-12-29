//  StoriesViewToolbar.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/19/18.

import UIKit
import Interface

internal final class StoriesViewToolbar: UIToolbar {
    let switchMode        = UISwitch(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
    let barItemMode       = UIBarButtonItem()
    let barItemHelp       = UIBarButtonItem(image: UIImage(named: "59-info-symbol"),
                                            style: .plain, target: self,
                                            action: #selector( _toolbarActionHelp(sender_:) ))
    let barItemSpace      = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil )
    var touchTip:         LongTouchTip?     = nil
    weak var controller:  UIViewController? = nil

    internal func toolbarSetup( controller: UIViewController ) {
        self.controller = controller
        if ( barItemMode.customView == nil ) {
            self._toolbarModeSet()
            barItemMode.customView = self.switchMode
            switchMode.addTarget(self, action: #selector(_modeSwitchEvent(sender:forEvent:)),
                                 for: UIControl.Event.valueChanged )
        }
        if ( touchTip == nil ) {
            touchTip = LongTouchTip(view: self )
            touchTip!.addTipTarget(barItem: barItemMode,
                                   text: "Switch between view and edit mode", durationSec: 5)
            touchTip!.addTipTarget(barItem: barItemHelp,
                                   text: "About ex04-Editor", durationSec: 4 )
        }

        let items = [self.barItemMode, self.barItemSpace, self.barItemHelp ]
        if ( self.items != items ) {
            self.setItems( items, animated: false )
        }
    }

    // MARK: UIBarButtonItem actions
    @objc private func _toolbarActionHelp( sender_: UIBarButtonItem ) {
        self.touchTip!.show()
    }
    @objc private func _modeSwitchEvent( sender: UISwitch, forEvent event_: UIEvent ) {
        let newState = StateManager.singleton.getStateBool( .isEditMode_Bool ) ? false : true
        _ = StateManager.singleton.setState( .isEditMode_Bool, bool: newState )
        _ = StateManager.singleton.setState( .toolBarHeight_Int, int: newState ? 44 : 0 )
        let message = newState ? "Edit Mode" : "View Mode"
        let easyTip = EasyTipView(text: message, preferences: LongTouchTip.tipViewPreferences, delegate: nil )
        easyTip.show(forView: sender )
        sender.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
            easyTip.dismiss()
            sender.isEnabled = true
        }
        self._toolbarModeSet()
    }
    private func _toolbarModeSet() {
        self.switchMode.isOn = StateManager.singleton.getStateBool( .isEditMode_Bool )
    }
}
