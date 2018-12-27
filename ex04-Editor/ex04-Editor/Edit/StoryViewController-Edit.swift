//  StoryViewController-Edit.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/27/18.

import UIKit
import Model
import Interface

extension StoryViewController: EditToolbarDelegate {
    
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        print("add")
    }
    
    func deleteAction(toolbar: UIToolbar) {
        precondition( self.story != nil )
        let deleteAlert = DeleteAlert(parent: self, deleteId: self.story!.uniqueId )
        deleteAlert.present( self._deleteActionHandler(_:_:) )
    }
    
    func editAction(toolbar: UIToolbar) {
        print("edit")
        let textEdit = TextEditController()
        self.present( textEdit, animated: true, completion: nil )
    }
    
    func reorderAction(toolbar: UIToolbar) {
        print("reorder")
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
            toolbar.barItemReorder.isEnabled = ( self.story?.aChapterId.count ?? 0 ) > 1
        }
    }
}
