//
//  LPLivePhoto.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

struct LPLiveAsset {
    var name: String
}

extension LPLiveAsset: Codable {
    // do nothing
}

// MARK: - Mocks

extension LPLiveAsset {
    
    static func mockAssets() -> [LPLiveAsset] {
        return [
            LPLiveAsset(name: "709e38db7637c2bd20f35073a96a45cc"),
            LPLiveAsset(name: "12e56c1d1137fb114e360b7a9970f3f9")
        ]
    }
    
}
