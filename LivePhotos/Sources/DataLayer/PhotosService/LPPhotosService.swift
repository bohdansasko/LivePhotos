//
//  LPPhotosService.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import PhotosUI

protocol LPLivePhotosService {
    func fetchPhotos() -> Promise<[PHLivePhoto]>
}
