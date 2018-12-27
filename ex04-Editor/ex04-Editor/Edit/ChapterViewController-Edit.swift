//  ChapterViewController-Edit.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/27/18.

import UIKit
import Model
import Interface

extension ChapterViewController: EditToolbarDelegate {
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        print("add")
    }
    
    func deleteAction(toolbar: UIToolbar) {
        precondition( self.chapter != nil )
        let deleteAlert = DeleteAlert(parent: self, deleteId: self.chapter!.uniqueId )
        deleteAlert.present( self._deleteActionHandler(_:_:) )
    }
    
    func editAction(toolbar: UIToolbar) {
        print("edit")
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
}
