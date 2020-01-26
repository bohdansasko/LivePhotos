//
//  LPPhotosService.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import Photos

protocol LPLivePhotosService {
    func fetchPhotos(by assets: [LPLiveAsset]) -> Promise<[PHLivePhoto]>
}
