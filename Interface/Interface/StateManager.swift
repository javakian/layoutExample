//  StateManager.swift
//  Interface
//
//
//  Created by CHH51 on 12/19/18.

import UIKit

public final class StateManager {
    // MARK: static
    private static var _singleton: StateManager? = nil
    public  static var  singleton:  StateManager { get {
        if ( StateManager._singleton == nil ) {
            StateManager._singleton = StateManager()
        }
        return StateManager._singleton!
    }}
    // MARK: public Constants
    private(set) public var globalLayoutConstants: [String: Any] = [
        "bkgcViewColor"      : UIColor.lightGray,
        "bkgdLabelColor"     : UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5),
        "bkgdTextInputColor" : UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.5),
        "bkgrButtonColor"    : UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.5)
        ]
    
    // MARK: public Layout state
    public enum State: String {
        case isEditMode_Bool    = "isEditMode_Bool"
        case toolBarHeight_Int  = "toolBarHeight_Int"
    }
    private(set) public var globalState: [String: Any] = [
        State.isEditMode_Bool.rawValue      : false,
        State.toolBarHeight_Int.rawValue    : 0
    ]
    public func getStateBool( _ state_: State ) -> Bool {
        switch state_ {
        case .isEditMode_Bool:
            return self.globalState[ state_.rawValue ] as! Bool 
        default:
            preconditionFailure( "invalid call State: \(state_.rawValue)")
        }

    }
    public func setState( _ state_: State, bool bool_: Bool ) -> Bool {
        var changed = false
        switch state_ {
        case .isEditMode_Bool:
            if ( (self.globalState[ state_.rawValue ] as! Bool) != bool_ ) {
                self.globalState[ state_.rawValue ] = bool_
                changed = true
            }
        default:
            preconditionFailure( "invalid call State: \(state_.rawValue)")
        }
        return changed
    }
    public func setState( _ state_: State, int int_: Int ) -> Bool {
        var changed = false
        switch state_ {
        case .toolBarHeight_Int:
            if ( (self.globalState[ state_.rawValue ] as! Int) != int_ ) {
                self.globalState[ state_.rawValue ] = int_
                changed = true
            }
        default:
            preconditionFailure( "invalid call State: \(state_.rawValue)")
        }
        return changed
    }

    // MARK: private
    fileprivate init() {}
}
