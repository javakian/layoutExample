//  AVKit+Layout.swift
//  ex02-Viewer
//
//  Created by CHH51 on 12/6/18.

import AVFoundation
import AVKit
import Layout

extension AVPlayerViewController {
    open override class func create(with node: LayoutNode) throws -> AVPlayerViewController {
        let avController = self.init()
        let avSession = AVAudioSession.sharedInstance()
        try! avSession.setCategory( .playback, mode: .moviePlayback, options: .duckOthers )
        return avController
    }
}
