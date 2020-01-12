//
//  LPFakePhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

final class LPFakeLivePhotosService: LPLivePhotosService {
    
    func fetchPhotos() -> [LPLivePhoto] {
        return LPLivePhoto.mockPhotos()
    }
    
}
