//
//  LPLivePhoto.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

struct LPLivePhoto {
    var imageUrl: String
    var videoUrl: String
}

// MARK: - Mocks

extension LPLivePhoto {
    
    static func mockPhotos() -> [LPLivePhoto] {
        return [
            LPLivePhoto(imageUrl: "709e38db7637c2bd20f35073a96a45cc", videoUrl: "0e21e80d8b50a37f93caa380fe6d0a70"),
//            LPLivePhoto(imageUrl: "cdab193b86e53506966f2a9793c770da", videoUrl: "12e56c1d1137fb114e360b7a9970f3f9")
        ]
    }
    
}
