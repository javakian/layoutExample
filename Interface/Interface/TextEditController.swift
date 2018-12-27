//  TextEditController.swift
//  Interface
//
//  Created by CHH51 on 12/27/18.

import UIKit
import Layout

public final class TextEditController: UIViewController, LayoutLoading {
    private(set) public var     contextDescription: String?
    private(set) public var     initialValue:       String?
    private(set) public var     regEx:              NSRegularExpression?
    @IBOutlet           var     contextLabel:       UILabel?
    @IBOutlet           var     textView:           UITextView?
    @IBOutlet           var     rulesLabel:         UILabel?
    @IBOutlet           var     buttonSave:         UIButton?
    @IBOutlet           var     buttonCancel:       UIButton?
    private             var     _selfRetain:        TextEditController?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(named:     "TextEdit.xml",
                   bundle:    Bundle(for: type(of: self)),
                   constants: [String: Any]() )
        self._selfRetain = self
    }
    deinit {
        print("deinit TextEditController")
    }
    
    // Control actions
    @IBAction         func      actionSave() {
        print("save")
        self.dismiss(animated: true, completion: nil )
        self._selfRetain = nil
    }
    @IBAction         func      actionCancel() {
        print("cancel")
        self.dismiss(animated: true, completion: nil )
        self._selfRetain = nil
    }
}
