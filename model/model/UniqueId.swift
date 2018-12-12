//  UniqueId.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public class UniqueId: Hashable {
    public let uniqueId: Int
    
    internal init( uId: Int? ) {
        if ( uId != nil ) {
            precondition( UniqueId.isValidUniqueId( uId! ))
            self.uniqueId = uId!
        } else {
            self.uniqueId = UniqueId.newUniqueId() 
        }
    }
    // MARK: Hashable
    public static func == (lhs: UniqueId, rhs: UniqueId) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine( self.uniqueId )
    }
    
    // MARK: static
    private static var _setUniqueId    = Set<Int>(minimumCapacity: 100 )
    private static var _maxUniqueId    = Int.min
    
    private static func isValidUniqueId( _ uId_: Int ) -> Bool {
        let ( result, _ ) = _setUniqueId.insert( uId_ )
        if ( result == true ) {
            _maxUniqueId = max( _maxUniqueId, uId_ )
        }
        return result
    }
    
    private static func newUniqueId() -> Int {
        let nextId = _maxUniqueId + 1
        _ = isValidUniqueId( nextId )
        return nextId
    }
}

public enum eUId: Int {
    case phBHBasin_DogResting = 1
    case phBHBasin_Meadow    ,phBHBasin_Pano      ,phBHBasin_TrailBack ,phBHBasin_Wilderness
    case phEarthquakeLake_1  ,phEarthquakeLake_2  ,phEarthquakeLake_3  ,phEarthquakeLake_4
    case phMOR_Bear          ,phMOR_Blacksmith    ,phMOR_DinoBattle    ,phMOR_PioneerHouse
    case phMOR_PioneerKitchen,phMOR_TRex          ,phOFP_GallatinBridge,phOFP_RiverCliff
    case phLCCPW_EntryMarch  ,phLCCPW_WomenDancers,phLCCPW_MaleDancer
    
    case mvOFP_Falls
    
    case txMOR_Entry         ,txStorySummary01     ,txStorySummary02
    
    case chMOR               ,chOFP                ,chBHBasin           ,chEarthquakeLake
    case chLCCPW_Entry 
    
    case stYurtFirstTrip     ,stLCCommunityPowWow
}
