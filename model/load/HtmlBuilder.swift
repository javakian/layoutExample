//  HtmlBuilder.swift
//  Model
//
//  Created by Chris Hawkins (developer) on 12/7/18.
//  Copyright © 2018 Chris Hawkins (developer). All rights reserved.

import Foundation

public protocol BuildsHtml {
    func addToBuilder( _ builder_: HtmlBuilder )
}

public enum eHtmlTag: String {
    case html   =   "html"
    case h1     =   "h1"
    case h2     =   "h2"
    case li     =   "li"
    case p      =   "p"
    case ul     =   "ul"
}

public final class HtmlBuilder {
    private(set) public var   isFinished  = false
    private             var   _data:    Data
    
    public init() {
        self._data  = Data( capacity: 500 )
        self.beginTagClosed( .html )
        self.lineBreak() 
    }
    public func     product() -> Data {
        precondition( isFinished == true )
        return self._data
    }
    public func     finish() -> Void {
        if ( !isFinished ) {
            self.endTag( .html )
            isFinished = true
        }
    }
    public func     beginTagClose() {
        precondition( isFinished == false )
        self._data.append(contentsOf: ">".utf8)
    }
    public func     beginTagClosed( _ tag_: eHtmlTag ) {
        precondition( isFinished == false )
        self._data.append(contentsOf: "<\(tag_.rawValue)>".utf8)
    }
    public func     beginTagOpen( _ tag_: eHtmlTag ) {
        precondition( isFinished == false )
        self._data.append(contentsOf: "<\(tag_.rawValue)".utf8)
    }
    public func     endTag( _ tag_: eHtmlTag ) {
        precondition( isFinished == false )
        self._data.append(contentsOf: "</\(tag_.rawValue)>".utf8)
    }
    public func     content(_ content_: String ) {
        precondition( isFinished == false )
        self._data.append(contentsOf: content_.utf8 )
    }
    public func     lineBreak() {
        precondition( isFinished == false )
        self._data.append(contentsOf: "\n".utf8 )
    }
}
