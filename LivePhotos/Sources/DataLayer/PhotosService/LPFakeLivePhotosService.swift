//
//  LPFakePhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit

final class LPFakeLivePhotosService: LPLivePhotosService {
    
    func fetchPhotos() -> Promise<[LPLivePhoto]> {
        return Promise { seal in
            let bgQueue = DispatchQueue.global(qos: .background)
            bgQueue.asyncAfter(deadline: .now() + .seconds(2)) {
                seal.fulfill(LPLivePhoto.mockPhotos())
            }
        }
    }
    
}
