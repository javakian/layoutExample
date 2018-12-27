//  ContentSummary.swift
//  model
//
//  Created by CHH51 on 12/7/18.

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
        self._evaluateChapterId( chapterId )
    }
    public init( storyId: Int ) {
        self.nodeId = storyId
        self._evaluateStoryId( storyId )
    }
    private func _addSummary( _ summary: ContentSummary ) {
        self.countImage += summary.countImage
        self.countMovie += summary.countMovie
        self.countText  += summary.countText
    }
    private func _evaluateAssetId( _ assetId: Int ) {
        if let contentIndex = ContentIndex.singleton.getBy(itemId: assetId) {
            switch contentIndex.itemContentType {
            case .chapter:
                self._evaluateChapterId( assetId )
            case .image:
                self.countImage += 1
            case .movie:
                self.countMovie += 1
            case .story:
                self._evaluateStoryId( assetId )
            case .text:
                self.countText += 1
            case .unknown:
                preconditionFailure("unexpected")
            }
        }
     }
    private func _evaluateChapterId( _ chapterId: Int ) {
        if let chapter = Chapter.getById( chapterId ) {
            for contentId in chapter.aUniqueId {
                self._evaluateAssetId( contentId )
            }
        }
    }
    private func _evaluateStoryId( _ storyId: Int ) {
        if let story = Story.getById( storyId ) {
            let summaryTotal = ContentSummary(assetId: story.summaryId )
            self._addSummary( summaryTotal )
            for chapterId in story.aChapterId {
                let chapterTotal = ContentSummary(chapterId: chapterId )
                self._addSummary( chapterTotal )
            }
        }
    }
}
