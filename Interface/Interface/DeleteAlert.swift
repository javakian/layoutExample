//  DeleteAlert.swift
//  Interface
//
//  Created by CHH51 on 12/25/18.

import UIKit
import Model

public final class DeleteAlert {
    internal    let  parentController:   UIViewController
    internal    let  deleteUniqueId:     Int
    internal    let  contentItem:        ContentItem
    private     var  _completionHandler: ((_ deleted: Bool, _ uniqueId: Int ) -> Void )? = nil
    private     var  _alertController:   UIAlertController? = nil
    private     var  _selfRetain:        DeleteAlert?       = nil
    
    public init( parent:   UIViewController,
                 deleteId: Int  ) {
        self.parentController   = parent
        self.deleteUniqueId     = deleteId
        self.contentItem        = ContentIndex.singleton.getBy(itemId: deleteId )!
    }
    
    public func present( _ completionHandler_: @escaping ((_ didDelete_: Bool,_ deleteId_: Int) -> Void) ) {
        precondition(self._alertController == nil, "Alert is already active")
        self._selfRetain = self
        self._completionHandler  = completionHandler_
        let title   = "Delete \(self.contentItem.itemContentType.rawValue) ?"
        let summary = ContentSummary.init(assetId: self.deleteUniqueId )
        let message = "\(summary.countImage) 🌃 \(summary.countMovie) 📽 \(summary.countText) 📖"
        self._alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self._alertController!.addAction( UIAlertAction(title: "Delete", style: .destructive ) {
            [weak self] _ in self?._handleDeleteAction() } )
        self._alertController!.addAction( UIAlertAction(title: "Cancel", style: .cancel      ) {
            [weak self] _ in self?._handleCancelAction() } )
        self._alertController!.preferredAction = self._alertController!.actions[1]
        self.parentController.present(self._alertController!, animated: true, completion: nil )
    }
    // MARK: private
    private func _handleDeleteAction() -> Void {
        self._completionHandler!( true, self.deleteUniqueId )
        self._selfRetain = nil
    }
    private func _handleCancelAction() -> Void {
        self._completionHandler!( false, self.deleteUniqueId )
        self._selfRetain = nil
    }
}
