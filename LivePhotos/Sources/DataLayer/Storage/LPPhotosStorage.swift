//
//  LPPhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/25/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import Photos

protocol LPPhotosStorage {
    func savePhoto(_ livePhoto: PHLivePhoto) -> Promise<Bool>
}
