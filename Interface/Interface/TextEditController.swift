//  TextEditController.swift
//  Interface
//
//  Created by CHH51 on 12/27/18.

import UIKit
import Layout


public final class TextEditController: UIViewController, LayoutLoading {
    private(set) public var     contextDescription: String?
    private(set) public var     initialValue:       String?
    private(set) public var     rulesDescription:   String?
    private(set) public var     regEx:              NSRegularExpression?
    @IBOutlet           var     stackView:          UIStackView?
    @IBOutlet           var     contextLabel:       UILabel?
    @IBOutlet           var     textView:           UITextView?
    @IBOutlet           var     rulesLabel:         UILabel?
    @IBOutlet           var     buttonSave:         UIButton?
    @IBOutlet           var     buttonCancel:       UIButton?
    private             var     _selfRetain:        TextEditController?
    private             var     _completionHandler: ((_ changed: Bool,_ newValue: String? ) -> Void )? = nil
    private             var     _textViewDelegate: TextViewDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(named:     "TextEdit.xml",
                   bundle:    Bundle(for: type(of: self)),
                   constants: StateManager.singleton.globalLayoutConstants,
                              ["context":    self.contextDescription!,
                               "initial":    self.initialValue!,
                               "rules":      self.rulesDescription!   ] )
        self._selfRetain        = self
        self._textViewDelegate  = TextViewDelegate(parent: self )
    }
    deinit {
        print("deinit TextEditController")
    }
    public func setRules( context:  String,
                          initial:  String,
                          rules:    String,
                          regEx:    NSRegularExpression ) {
        precondition(self._selfRetain == nil, "must be set prior to present()")
        self.contextDescription     = context
        self.initialValue           = initial
        self.rulesDescription       = rules
        self.regEx                  = regEx
    }
    public func present( parent: UIViewController,
                         _ handler_: @escaping ((_ changed: Bool,_ newValue: String? ) -> Void )) {
        self._completionHandler = handler_
        parent.present( self, animated: true, completion: nil )
    }
    // UITextViewDelegate
    fileprivate class TextViewDelegate: NSObject, UITextViewDelegate {
        let parent: TextEditController
        
        init( parent: TextEditController ) {
            self.parent = parent
            super.init()
            parent.textView!.delegate = self
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if ( textView == parent.textView! ) {
                let curText  = textView.text!
                let isValid  = parent.regEx!.matches( curText )
                let rulesMsg = isValid ? "- OK" : " * Opps - invalid *"
                let rulesLbl = parent.rulesDescription! + rulesMsg
                parent.buttonSave!.isEnabled = isValid
                parent.rulesLabel!.text      = rulesLbl 
            }
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            print("begin editing")
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            print("end editing")
        }

    }

    
    // Control actions
    @IBAction         func      actionSave() {
        print("save")
        let newValue = self.textView!.text
        self._completionHandler!( true, newValue )
        self._completeAction()
    }
    @IBAction         func      actionCancel() {
        self._completionHandler!( false, nil )
        self._completeAction()
    }
    private func                _completeAction() {
        self._completionHandler = nil
        self.dismiss(animated: true, completion: nil )
        self._selfRetain       = nil
        self._textViewDelegate = nil
    }
}
