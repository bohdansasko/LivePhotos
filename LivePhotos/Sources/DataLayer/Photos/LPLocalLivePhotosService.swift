//
//  LPFakePhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import PhotosUI

final class LPLocalLivePhotosService {
    // do nothing
}

// MARK: - Help methods

private extension LPLocalLivePhotosService {
    
    func requestPhoto(with res: LPLiveAsset, completion: @escaping (PHLivePhoto?, Error?) -> Void) {
        guard let imageURL = Bundle.main.url(forResource: res.name, withExtension: "JPG") else {
            assertionFailure("required image")
            completion(nil, LPLivePhotoError.missingImageAsset)
            return
        }
        guard let videoURL = Bundle.main.url(forResource: res.name, withExtension: "mov") else {
            assertionFailure("required video")
            completion(nil, LPLivePhotoError.missingVideoAsset)
            return
        }

        LivePhoto.requestLivePhoto(imageURL: imageURL, videoURL: videoURL, completion: { livePhoto, error in
            completion(livePhoto, error)
        })
    }
    
}

// MARK: - LPLivePhotosService

extension LPLocalLivePhotosService: LPLivePhotosService {
    
    func fetchPhotos(by assets: [LPLiveAsset]) -> Promise<[PHLivePhoto]> {
        return Promise { seal in
            var livePhotos = [PHLivePhoto]()
            
            let dg = DispatchGroup()
            var lvError: Error?
            
            assets.forEach { res in
                dg.enter()
                self.requestPhoto(with: res, completion: { (livePhoto, error) in
                    defer { dg.leave() }
                    
                    if let err = error {
                        log.error(err)
                        lvError = err
                    }
                    
                    if let lv = livePhoto {
                        livePhotos.append(lv)
                    }
                })
            }
            
            dg.notify(queue: .main) {
                if let err = lvError {
                    seal.reject(err)
                } else {
                    seal.fulfill(livePhotos)
                }
            }
            
        }
    }
    
}
