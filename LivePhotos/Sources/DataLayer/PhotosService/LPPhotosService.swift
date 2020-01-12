//
//  LPPhotosService.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

protocol LPLivePhotosService {
    func fetchPhotos() -> [LPLivePhoto]
}
