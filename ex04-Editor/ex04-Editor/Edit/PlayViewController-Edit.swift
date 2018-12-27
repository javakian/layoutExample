//  PlayViewController-Edit.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/24/18.

import UIKit
import Model
import Interface

extension PlayViewController: EditToolbarDelegate {
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        preconditionFailure("invalid - add")
    }
    func deleteAction(toolbar: UIToolbar) {
        precondition( self.aAssetId.count == 1 )
        let deleteAlert = DeleteAlert(parent: self, deleteId: self.aAssetId[0] )
        deleteAlert.present( self._deleteActionHandler(_:_:) )
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
    // MARK: toolbar action handlers
    private func _deleteActionHandler(_ deleted: Bool, _ uniqueId: Int ) -> Void {
        if ( deleted ) {
            ContentManager.deleteBy(itemId: uniqueId )
            self.navigationController?.popViewController(animated: true )
        }
    }
    // MARK: internal - extension of main class file 
    internal func _viewDidLoadEdit() {
        if let toolbar = self.editToolbar {
            toolbar.toolbarSetup(controller: self, delegate: self )
            toolbar.items = [toolbar.barItemDelete, toolbar.barItemSpace, toolbar.barItemEdit,
                             toolbar.barItemSpace, toolbar.barItemMove]
        }
    }
}
