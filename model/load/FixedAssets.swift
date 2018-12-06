//  FixedAssets.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

/// Collection of static functions to load the initial set of assets
public class FixedAssets {
    public static func loadAll() {
        self.loadImage()
        self.loadMovie()
        self.loadText()
        self.loadChapter()
        self.loadStory()
    }
    // MARK: private
    private static func loadChapter() {
        Chapter.addChapter(Chapter(id: eUId.chMOR.rawValue,
                                   title: "Museum of the Rockies",
                                   aId: [ eUId.phMOR_TRex.rawValue,
                                          eUId.txMOR_Entry.rawValue,
                                          eUId.phMOR_Bear.rawValue,
                                          eUId.phMOR_DinoBattle.rawValue,
                                          eUId.phMOR_PioneerHouse.rawValue,
                                          eUId.phMOR_PioneerKitchen.rawValue,
                                          eUId.phMOR_Blacksmith.rawValue]))
        Chapter.addChapter(Chapter(id: eUId.chOFP.rawValue,
                                   title: "Ousel Falls, Big Sky, MT",
                                   aId: [ eUId.phOFP_GallatinBridge.rawValue,
                                          eUId.phOFP_RiverCliff.rawValue,
                                          eUId.mvOFP_Falls.rawValue]))
        Chapter.addChapter(Chapter(id: eUId.chBHBasin.rawValue,
                                   title: "Beehive Basin Trail, Big Sky, MT",
                                   aId: [ eUId.phBHBasin_Pano.rawValue,
                                          eUId.phBHBasin_Wilderness.rawValue,
                                          eUId.phBHBasin_Meadow.rawValue,
                                          eUId.phBHBasin_TrailBack.rawValue,
                                          eUId.phBHBasin_DogResting.rawValue]))
        Chapter.addChapter(Chapter(id: eUId.chEarthquakeLake.rawValue,
                                   title: "Earthquake Lake Visitor Center, Ennis, MT",
                                   aId: [ eUId.phEarthquakeLake_1.rawValue,
                                          eUId.phEarthquakeLake_2.rawValue,
                                          eUId.phEarthquakeLake_3.rawValue,
                                          eUId.phEarthquakeLake_4.rawValue ]))
    }
    private static func loadImage() {
        Image.addImage( Image(id: eUId.phBHBasin_DogResting.rawValue,
                              rName: "BHBasin_DogResting.jpg",
                              caption: "Big hike for such short Corgi legs."))
        Image.addImage( Image(id: eUId.phBHBasin_Meadow.rawValue,
                              rName: "BHBasin_Meadow.jpg",
                              caption: "Turnaround point, about 1/2 mile short of Beehive Basin"))
        Image.addImage( Image(id: eUId.phBHBasin_Pano.rawValue,
                              rName: "BHBasin_Pano.jpg",
                              caption: "About 1 mile up trail, in huge meadow of flowers"))
        Image.addImage( Image(id: eUId.phBHBasin_TrailBack.rawValue,
                              rName: "BHBasin_TrailBack.jpg",
                              caption: "Heading back down a steep rocky part of the trail"))
        Image.addImage( Image(id: eUId.phBHBasin_Wilderness.rawValue,
                              rName: "BHBasin_Wilderness.jpg",
                              caption: "Steady climb into Lee Metcalf Wilderness Area, and more dead trees"))
        Image.addImage( Image(id: eUId.phEarthquakeLake_1.rawValue,
                              rName: "EarthquakeLake_1.jpg",
                              caption: "Lake formed by landslide"))
        Image.addImage( Image(id: eUId.phEarthquakeLake_2.rawValue,
                              rName: "EarthquakeLake_2.jpg",
                              caption: nil))
        Image.addImage( Image(id: eUId.phEarthquakeLake_3.rawValue,
                              rName: "EarthquakeLake_3.jpg",
                              caption: nil))
        Image.addImage( Image(id: eUId.phEarthquakeLake_4.rawValue,
                              rName: "EarthquakeLake_4.jpg",
                              caption: "Source of the slide"))
        Image.addImage( Image(id: eUId.phMOR_Bear.rawValue,
                              rName: "MOR_Bear.jpg",
                              caption: "Children's section - Bear sculpture from common materials"))
        Image.addImage( Image(id: eUId.phMOR_Blacksmith.rawValue,
                              rName: "MOR_Blacksmith.jpg",
                              caption: "Working blacksmith shop in the original pioneer sod roof"))
        Image.addImage( Image(id: eUId.phMOR_DinoBattle.rawValue,
                              rName: "MOR_DinoBattle.jpg",
                              caption: "Possible look of a Velociraptor"))
        Image.addImage( Image(id: eUId.phMOR_PioneerHouse.rawValue,
                              rName: "MOR_PioneerHouse.jpg",
                              caption: "Pioneer House from early 1900s, relocated to museum"))
        Image.addImage( Image(id: eUId.phMOR_PioneerKitchen.rawValue,
                              rName: "MOR_PioneerKitchen.jpg",
                              caption: "Kitchen with wood stove and basin sink (no plumbing)"))
        Image.addImage( Image(id: eUId.phMOR_TRex.rawValue,
                              rName: "MOR_TRex.jpg",
                              caption: "entrance with T-Rex skeletion"))
        Image.addImage( Image(id: eUId.phOFP_RiverCliff.rawValue,
                              rName: "OFP_RiverCliff.jpg",
                              caption: "River carved cliff along trail to Ousel Falls"))
        Image.addImage( Image(id: eUId.phOFP_GallatinBridge.rawValue,
                              rName: "OFP_GallatinRiverBridge.jpg",
                              caption: "Ousel Falls Park, bridge over West Fork Gallatin River"))
    }
    private static func loadMovie() {
        Movie.addMovie( Movie(id: eUId.mvOFP_Falls.rawValue,
                              rName: "OFP_Falls.m4v",
                              caption: "On the middle step of Ousel Falls"))
    }
    private static func loadStory() {
        Story.addStory( Story(id: eUId.stYurtFirstTrip.rawValue,
                              label: "First Trip in Yurt",
                              summaryId: eUId.txStorySummary.rawValue,
                              aChapterId: [ eUId.chMOR.rawValue,
                                            eUId.chOFP.rawValue,
                                            eUId.chBHBasin.rawValue,
                                            eUId.chEarthquakeLake.rawValue]))
    }
    private static func loadText() {
        let p1a = Para(head: Heading( .h1, "Museum of the Rockies"),
                       aBody: [Body(.list, "Bozeman, Montana"), Body(.list, "July 24, 2017")] )
        let p1b = Para(head: nil,
                       aBody: [Body(.text, "Inside has geology, dinosaurs, pioneer and native history, and a planetarium."),
                               Body(.text, "Outside has pioneer home, workshop, and garden.")])
        Text.addText( Text(id: eUId.txMOR_Entry.rawValue,
                           aPara: [p1a, p1b]))
        let p2a = Para(head: Heading(.h2, "First Trip in Yurt"),
                       aBody: [ Body(.list, "Museum of the Rockies, Bozeman, MT"),
                                Body(.list, "Ousel Falls, Big Sky, MT"),
                                Body(.list, "eehive Meadows, Big Sky, MT"),
                                Body(.list, "Earthquake Lake, Ennis, MT")])
        Text.addText( Text(id: eUId.txStorySummary.rawValue,
                           aPara: [ p2a ]))
    }
    /// This is a static class
    private init() {}
}
