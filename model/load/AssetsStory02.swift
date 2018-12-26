//  AssetsStory02.swift
//  model
//
//  Created by CHH51 on 12/10/18.
import Foundation

/// Collection of static functions to load the initial set of assets for story 1
public class AssetsStory02 {
    public static func loadAll() {
        self.loadImage()
        self.loadMovie()
        self.loadText()
        self.loadChapter()
        self.loadStory()
    }
    // MARK: private
    private static func loadChapter() {
        ContentManager.addChapter(Chapter(id: eUId.chLCCPW_Entry.rawValue,
                                          title: "Entry March",
                                          aId: [ eUId.phLCCPW_EntryMarch.rawValue,
                                                 eUId.phLCCPW_WomenDancers.rawValue,
                                                 eUId.phLCCPW_MaleDancer.rawValue]))
    }
    private static func loadImage() {
        ContentManager.addImage( Image(id: eUId.phLCCPW_EntryMarch.rawValue,
                                       rName: "LCCPW_EntryMarch.png",
                                       caption: "Entry march for all dancers, led by flags of nations and tribes"))
        ContentManager.addImage( Image(id: eUId.phLCCPW_WomenDancers.rawValue,
                                       rName: "LCCPW_WomenDancers.png",
                                       caption: "Older women dancers during entry march"))
        ContentManager.addImage( Image(id: eUId.phLCCPW_MaleDancer.rawValue,
                                       rName: "LCCPW_MaleDancer.png",
                                       caption: "Male dancer during dance of older men"))
    }
    private static func loadMovie() {
    }
    private static func loadStory() {
        ContentManager.addStory( Story(id: eUId.stLCCommunityPowWow.rawValue,
                                       label: "2018 Last Chance PowWow",
                                       summaryId: eUId.txStorySummary02.rawValue,
                                       aChapterId: [ eUId.chLCCPW_Entry.rawValue]))
    }
    private static func loadText() {
        let p2a = Para(head: Heading(.h2, "September 30, 2018"),
                       aBody: [ Body(.list, "Helena, Montana") ])
        ContentManager.addText( Text(id: eUId.txStorySummary02.rawValue,
                                     aPara: [ p2a ]))
    }
    /// This is a static class
    private init() {}
}
