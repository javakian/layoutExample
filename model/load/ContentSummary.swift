//  ContentSummary.swift
//  model
//
//  Created by Chris Hawkins (developer) on 12/7/18.
//  Copyright © 2018 Chris Hawkins (developer). All rights reserved.

import Foundation

public final class ContentSummary {
    public              let nodeId:     Int
    public private(set) var countImage: Int     = 0
    public private(set) var countMovie: Int     = 0
    public private(set) var countText:  Int     = 0
    
    public init( chapterId: Int ) {
        self.nodeId         =   chapterId
        if let chapter = Chapter.getById( chapterId ) {
            for contentId in chapter.aUniqueId {
                self.evaluateAssetId( contentId )
              }
        }
    }
    
    private func evaluateAssetId( _ assetId: Int ) {
        if Image.getById( assetId ) != nil {
            self.countImage += 1
            return
        }
        if Movie.getById( assetId ) != nil {
            self.countMovie += 1
            return
        }
        if Text.getById( assetId ) != nil {
            self.countText += 1
            return
        }
    }
}
