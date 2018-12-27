//  ChapterViewController-Edit.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/27/18.

import UIKit
import Model

extension ChapterViewController: EditToolbarDelegate {
    // MARK: EditToolbarDelegate
    func addAction(toolbar: UIToolbar) {
        print("add")
    }
    
    func deleteAction(toolbar: UIToolbar) {
        print("delete")
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
}
