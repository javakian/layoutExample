//  EditToolbar.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/22/18.

import UIKit
import Interface

internal final class EditToolbar: UIToolbar {
    weak var controller:        UIViewController?    = nil
    weak var toolbarDelegate:   EditToolbarDelegate? = nil
         let barItemAdd       = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                action: #selector(_addAction(sender_:)))
         let barItemDelete    = UIBarButtonItem(barButtonSystemItem: .trash, target: self,
                                               action: #selector(_deleteAction(sender_:)))
         let barItemEdit      = UIBarButtonItem(barButtonSystemItem: .compose, target: self,
                                               action: #selector(_editAction(sender_:)))
         let barItemReorder   = UIBarButtonItem(image: UIImage(named: "259-list"),
                                               style: .plain, target: self,
                                               action: #selector(_reorderAction(sender_:)))
         let barItemMove      = UIBarButtonItem(barButtonSystemItem: .organize, target: self,
                                               action: #selector(_moveAction(sender_:)))
         let barItemSpace     = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil )

    internal func toolbarSetup( controller: UIViewController,
                                delegate:   EditToolbarDelegate? ) {
        self.controller      = controller
        self.toolbarDelegate = delegate
        self.setItems([barItemAdd,barItemSpace, barItemDelete, barItemSpace, barItemEdit,
                       barItemSpace, barItemReorder, barItemSpace, barItemMove], animated: false)
    }
    // MARK: UIBarButtonActions
    @objc private func    _addAction( sender_: UIBarButtonItem ) {
        if let delegate_ = self.toolbarDelegate {
            delegate_.addAction(toolbar: self )
        }
    }
    @objc private func    _deleteAction( sender_: UIBarButtonItem ) {
        if let delegate_ = self.toolbarDelegate {
            delegate_.deleteAction(toolbar: self )
        }
    }
    @objc private func    _editAction( sender_: UIBarButtonItem ) {
        if let delegate_ = self.toolbarDelegate {
            delegate_.editAction(toolbar: self )
        }
    }
    @objc private func    _reorderAction( sender_: UIBarButtonItem ) {
        if let delegate_ = self.toolbarDelegate {
            delegate_.reorderAction(toolbar: self )
        }
    }
    @objc private func    _moveAction( sender_: UIBarButtonItem ) {
        if let delegate_ = self.toolbarDelegate {
            delegate_.moveAction(toolbar: self )
        }
    }
}

internal protocol EditToolbarDelegate: AnyObject {
    func    addAction(     toolbar: UIToolbar )
    func    deleteAction(  toolbar: UIToolbar )
    func    editAction(    toolbar: UIToolbar )
    func    reorderAction( toolbar: UIToolbar )
    func    moveAction(    toolbar: UIToolbar )
}
