//  StoriesViewToolbar.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/19/18.

import UIKit
import Interface

internal final class StoriesViewToolbar: UIToolbar {
    let switchMode        = UISwitch(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
    let barItemMode       = UIBarButtonItem()
    let barItemHelp       = UIBarButtonItem(title: "About", style: .plain , target: self,
                                            action: #selector(_toolbarActionHelp(sender_:)))
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                self.touchTip!.show()
            }
        }

        let items = [self.barItemMode, self.barItemSpace, self.barItemHelp ]
        if ( self.items != items ) {
            self.setItems( items, animated: false )
        }
    }

    // MARK: UIBarButtonItem actions
    @objc private func _toolbarActionHelp( sender_: UIBarButtonItem ) {
    }
    @objc private func _modeSwitchEvent( sender: UISwitch, forEvent event_: UIEvent ) {
        let newState = StateManager.singleton.getStateBool( .isEditMode_Bool ) ? false : true
        _ = StateManager.singleton.setState( .isEditMode_Bool, bool: newState )
        self._toolbarModeSet()
    }
    private func _toolbarModeSet() {
        self.switchMode.isOn = StateManager.singleton.getStateBool( .isEditMode_Bool )
    }
}
