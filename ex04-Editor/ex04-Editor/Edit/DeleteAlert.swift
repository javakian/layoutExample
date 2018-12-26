//  DeleteAlert.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/25/18.

import UIKit
import Model

final class DeleteAlert {
    let             parentController:   UIViewController
    let             deleteUniqueId:     Int
    let             owningUniqueId:     Int?
    private var     _completionHandler: ((_ deleted: Bool, _ uniqueId: Int ) -> Void )? = nil
    private var     _alertController:   UIAlertController? = nil
    
    init( parent:   UIViewController,
          deleteId: Int,
          owningId: Int? ) {
        self.parentController   = parent
        self.deleteUniqueId     = deleteId
        self.owningUniqueId     = owningId
    }
    
    func present( _ completionHandler_: @escaping ((_ didDelete_: Bool,_ deleteId_: Int) -> Void) ) {
        precondition(self._alertController == nil, "Alert is already active")
        self._completionHandler  = completionHandler_
        
    }
}
