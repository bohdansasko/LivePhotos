//
//  LPFakePhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import PhotosUI

final class LPFakeLivePhotosService: LPLivePhotosService {
    
    func fetchPhotos() -> Promise<[PHLivePhoto]> {
        return Promise { seal in
            let bgQueue = DispatchQueue.global(qos: .background)
            bgQueue.asyncAfter(deadline: .now() + .seconds(2)) {
                
                var livePhotos = [PHLivePhoto]()
                let photosGroup = DispatchGroup()
                
                let livePhotosResources = LPLivePhoto.mockPhotos()
                let resourcePath = Bundle.main.resourcePath!
                
                livePhotosResources.forEach { res in
                    let imageURL = Bundle.main.url(forResource: res.imageUrl, withExtension: "jpg")!
                    let videoURL = Bundle.main.url(forResource: res.videoUrl, withExtension: "mov")!
                    
                    photosGroup.enter()
                    
                    LivePhoto.generate(
                        from: imageURL,
                        videoURL: videoURL,
                        progress: { [res] percent in
                            log.debug("generating file \(res.imageUrl) - \(res.videoUrl)", "\(percent)%")
                        },
                        completion: { livePhoto, resources in
                            defer { photosGroup.leave() }
                            guard let livePhoto = livePhoto else { return }
                            guard let resources = resources else { return }
                            livePhotos.append(livePhoto)
                            LivePhoto.saveToLibrary(resources, completion: { s in
                                log.info("isSaved - \(s)")
                            })
                        }
                    )
                }
                
                photosGroup.notify(queue: .main, execute: {
                    seal.fulfill(livePhotos)
                })
            }
        }
    }
    
}
