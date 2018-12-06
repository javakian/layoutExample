//  Chapter.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public final class Chapter: UniqueId {
    public  var title:          String
    public  var aUniqueId:      [Int]
    
    public  init( id:           Int?,
                  title:        String,
                  aId:          [Int]) {
        self.title          =   title
        self.aUniqueId      =   aId 
        super.init(uId: id )
    }
    
    // MARK: static
    private static var  globalDictionaryById    =    [Int: Chapter]()
    public  static func getById( _ id_: Int ) -> Chapter? {
        return globalDictionaryById[ id_ ]
    }
    public  static func addChapter( _ chapter_: Chapter ) {
        globalDictionaryById[ chapter_.uniqueId ] = chapter_
    }
    public  static func removeById( _ id_: Int ) {
        globalDictionaryById[ id_ ] = nil
    }
}
