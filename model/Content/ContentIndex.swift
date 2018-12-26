//  ContentIndex.swift
//  Model
//
//  Created by CHH51 on 12/7/18.

import Foundation

public enum eContentType: String {
    case story      = "Story"
    case chapter    = "Chapter"
    case movie      = "Movie"
    case text       = "Text"
    case image      = "Image"
    case unknown    = "unknown"
}

public final class ContentItem {
    private(set) public var     parentUniqueId:     Int?
                 public let     itemUniqueId:       Int
    private(set) public var     itemContentType:    eContentType
    
    public init( parentId:      Int,
                 itemId:        Int,
                 contentType:   eContentType ) {
        self.parentUniqueId     = parentId
        self.itemUniqueId       = itemId
        self.itemContentType    = contentType
    }
    public convenience init( parentId: Int,
                             itemId:   Int ) {
        self.init(parentId: parentId, itemId: itemId, contentType: .unknown )
    }
    public init( itemId:   Int,
                 type:     eContentType ) {
        self.parentUniqueId     = nil
        self.itemUniqueId       = itemId
        self.itemContentType    = type
    }
    public func set( parentId: Int? ) {
        self.parentUniqueId     = parentId
    }
    public func set( contentType: eContentType ) {
        precondition( contentType != .unknown)
        self.itemContentType    = contentType
    }
}

public final class ContentIndex {
    private var _dictItemId     = [Int: ContentItem](minimumCapacity: 100)

    public  func    getBy( itemId: Int ) -> ContentItem? {
        return _dictItemId[ itemId ]
    }
    public func     remove( itemId: Int ) {
        _dictItemId[ itemId ] = nil
    }
    internal func    update( item: ContentItem ) {
        if let existing = _dictItemId[ item.itemUniqueId ] {
            if ( item.parentUniqueId != nil ) {
                existing.set(parentId: item.parentUniqueId )
            }
            if ( item.itemContentType != .unknown ) {
                existing.set(contentType: item.itemContentType )
            }
        } else {
            _dictItemId[ item.itemUniqueId ] = item
        }
    }
    private init() {}
    // MARK: static
    public static let singleton = ContentIndex() 
}
