//  Text.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public enum eHeadStyle { case h1, h2 }
public enum eBodyStyle { case text, list }

public final class Heading {
    public var style:   eHeadStyle
    public var text:    String
    public init( _ style_: eHeadStyle, _ text_: String ) {
        style   = style_
        text    = text_
    }
}

public final class Body {
    public var style:   eBodyStyle
    public var text:    String
    public init( _ style_: eBodyStyle, _ text_: String ) {
        style   = style_
        text    = text_
    }
}

public final class Para {
    public var  heading:    Heading?
    public var  arrayBody:  [Body]
    public init( head:      Heading?,
                 aBody:     [Body] ) {
        heading     =   head
        arrayBody   =   aBody
    }
}

public final class Text: UniqueId {
    public var  aPara:  [Para]
    public init( id:             Int?,
                 aPara aPara_:   [Para] ) {
        self.aPara  = aPara_
        super.init(uId: id )
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
