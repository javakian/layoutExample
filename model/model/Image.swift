//  Image.swift
//  model
//
//  Created by CHH51 on 12/6/18.
import Foundation

public final class Image: UniqueId {
    public  let resourceName:    String
    public  var caption:         String?
    private var image:           UIImage?
    
    public  init( id:       Int?,
                  rName:    String,
                  caption:  String? ) {
        self.resourceName   =   rName
        self.caption        =   caption
        super.init(uId: id )
    }
    
    // MARK: static
    private static var  globalDictionaryById    =    [Int: Image]()
    public  static func getById( _ id_: Int ) -> Image? {
        return globalDictionaryById[ id_ ]
    }
    public  static func addImage( _ image_: Image ) {
        globalDictionaryById[ image_.uniqueId ] = image_
    }
    public  static func removeById( _ id_: Int ) {
        globalDictionaryById[ id_ ] = nil 
    }
}


