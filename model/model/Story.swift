//  Story.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public final class Story: UniqueId {
    public  var label:           String
    public  var summaryId:       Int
    public  var aChapterId:      [Int]
    
    public  init( id:           Int?,
                  label:        String,
                  summaryId:    Int,
                  aChapterId:   [Int]) {
        self.label          = label
        self.summaryId      = summaryId
        self.aChapterId     = aChapterId
        super.init(uId: id )
    }
    
    // MARK: static
    private static var  globalDictionaryById    =    [Int: Story]()
    public  static func getById( _ id_: Int ) -> Story? {
        return globalDictionaryById[ id_ ]
    }
    public  static func addStory( _ story_: Story ) {
        globalDictionaryById[ story_.uniqueId ] = story_
    }
    public  static func removeById( _ id_: Int ) {
        globalDictionaryById[ id_ ] = nil
    }
}
