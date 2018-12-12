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
    
    public init( assetId: Int ) {
        self.nodeId = assetId
        self._evaluateAssetId( assetId )
    }
    public init( chapterId: Int ) {
        self.nodeId    =   chapterId
        if let chapter = Chapter.getById( chapterId ) {
            for contentId in chapter.aUniqueId {
                self._evaluateAssetId( contentId )
              }
        }
    }
    public init( storyId: Int ) {
        self.nodeId = storyId
        if let story = Story.getById( storyId ) {
            let summaryTotal = ContentSummary(assetId: story.summaryId )
            self._addSummary( summaryTotal )
            for chapterId in story.aChapterId {
                let chapterTotal = ContentSummary(chapterId: chapterId )
                self._addSummary( chapterTotal )
            }
        }
    }
    private func _addSummary( _ summary: ContentSummary ) {
        self.countImage += summary.countImage
        self.countMovie += summary.countMovie
        self.countText  += summary.countText
    }
    private func _evaluateAssetId( _ assetId: Int ) {
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
