//  StoriesViewToolbar.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/19/18.

import UIKit

internal final class StoriesViewToolbar: UIToolbar {
    let switchMode        = UISwitch(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
    let barItemMode       = UIBarButtonItem()
    let barItemHelp       = UIBarButtonItem(title: "About", style: .plain , target: self,
                                            action: #selector(_toolbarActionHelp(sender_:)))
    let barItemSpace      = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil )
    weak var controller:  UIViewController? = nil

    internal func toolbarSetup( controller: UIViewController ) {
        self.controller = controller
        if ( barItemMode.customView == nil ) {
            self._toolbarModeSet()
            barItemMode.customView = self.switchMode
        }
        if ( barItemMode.action == nil ) {
            barItemMode.action = #selector(_toolbarActionMode(sender_:))
        }
        
        let items = [self.barItemMode, self.barItemSpace, self.barItemHelp ]
        if ( self.items != items ) {
            self.setItems( items, animated: false )
        }
    }

    // MARK: UIBarButtonItem actions
    @objc private func _toolbarActionHelp( sender_: UIBarButtonItem ) {
        print("help")
    }
    @objc private func _toolbarActionMode( sender_: UIBarButtonItem ) {
        let newState = StateManager.singleton.getStateBool( .isEditMode_Bool ) ? false : true
        _ = StateManager.singleton.setState( .isEditMode_Bool, bool: newState )
        self._toolbarModeSet()
    }
    private func _toolbarModeSet() {
        self.switchMode.isOn = StateManager.singleton.getStateBool( .isEditMode_Bool )
    }
}
