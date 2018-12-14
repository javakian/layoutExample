//  Movie.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation
import AVFoundation

public final class Movie: UniqueId {
    public  let resourceName:    String
    public  var caption:         String?
    private var _avPlayer:       AVPlayer?
    
    public  init( id:       Int?,
                  rName:    String,
                  caption:  String? ) {
        self.resourceName   =   rName
        self.caption        =   caption
        super.init(uId: id )
    }
    
    public func loadAVPlayer() -> AVPlayer {
        if ( _avPlayer == nil ) {
            let bundle = Bundle(for: type(of: self ))
            let url    = bundle.url(forResource: self.resourceName, withExtension: nil )!
            _avPlayer  = AVPlayer(url: url )
        }
        return _avPlayer! 
    }
    // MARK: static
    private static var  globalDictionaryById    =    [Int: Movie]()
    public  static func getById( _ id_: Int ) -> Movie? {
        return globalDictionaryById[ id_ ]
    }
    public  static func addMovie( _ movie_: Movie ) {
        globalDictionaryById[ movie_.uniqueId ] = movie_
    }
    public  static func removeById( _ id_: Int ) {
        globalDictionaryById[ id_ ] = nil
    }
}
