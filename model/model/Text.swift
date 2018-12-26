//  Text.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public enum eHeadStyle { case h1, h2 }
public enum eBodyStyle { case text, list }

public final class Heading: BuildsHtml {
    public var style:   eHeadStyle
    public var text:    String
    public init( _ style_: eHeadStyle, _ text_: String ) {
        style   = style_
        text    = text_
    }
    public func addToBuilder( _ builder_: HtmlBuilder ) {
        let tag = ( self.style == .h1 ) ? eHtmlTag.h1 : eHtmlTag.h2
        builder_.beginTagClosed( tag )
        builder_.content( self.text )
        builder_.endTag( tag )
        builder_.lineBreak()
    }
}

public final class Body: BuildsHtml {
    public var style:   eBodyStyle
    public var text:    String
    public init( _ style_: eBodyStyle, _ text_: String ) {
        style   = style_
        text    = text_
    }
    public func addToBuilder(_ builder_: HtmlBuilder) {
        if ( self.style == .text ) {
            builder_.content( self.text )
        } else {
            builder_.beginTagClosed( .li )
            builder_.content( self.text )
            builder_.endTag( .li )
            builder_.lineBreak()
        }
    }
}

public final class Para: BuildsHtml {
    public var  heading:    Heading?
    public var  arrayBody:  [Body]
    public init( head:      Heading?,
                 aBody:     [Body] ) {
        heading     =   head
        arrayBody   =   aBody
    }
    public func getSummary() -> String {
        if heading != nil {
            return heading!.text
        } else {
            return arrayBody[0].text 
        }
    }
    public func addToBuilder(_ builder_: HtmlBuilder) {
        var listActive = false
        func evalEndList() {
            if listActive {
                builder_.endTag( .ul )
                builder_.lineBreak()
                listActive = false
            }
        }
        self.heading?.addToBuilder( builder_ )
        builder_.beginTagClosed( .p )
        builder_.lineBreak()
        for body in self.arrayBody {
            switch body.style {
            case .list:
                if !listActive {
                    builder_.beginTagClosed( .ul )
                    builder_.lineBreak()
                    listActive = true
                }
            case .text:
                evalEndList()
            }
            body.addToBuilder( builder_ )
        }
        evalEndList()
        builder_.endTag( .p )
        builder_.lineBreak()
        return
    }
}

public final class Text: UniqueId, BuildsHtml {
    public var  aPara:  [Para]
    public init( id:             Int?,
                 aPara aPara_:   [Para] ) {
        self.aPara  = aPara_
        super.init(uId: id )
        ContentIndex.singleton.update(item: ContentItem(itemId: self.uniqueId, type: .text ))
    }
    public func addToBuilder(_ builder_: HtmlBuilder) {
        for para in self.aPara {
            para.addToBuilder( builder_ )
        }
    }
    // MARK: static
    private static var  globalDictionaryById    =    [Int: Text]()
    public  static func getById( _ id_: Int ) -> Text? {
        return globalDictionaryById[ id_ ]
    }
    public  static func addText( _ text_: Text ) {
        globalDictionaryById[ text_.uniqueId ] = text_
    }
    public  static func removeById( _ id_: Int ) {
        globalDictionaryById[ id_ ] = nil
    }
}
