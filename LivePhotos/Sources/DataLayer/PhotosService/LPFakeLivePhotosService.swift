//
//  LPFakePhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import PhotosUI

final class LPFakeLivePhotosService {
    private let customQueue = DispatchQueue(label: "com.lp.fake.livephotos.serial.queue")
}

// MARK: - LPLivePhotosService

extension LPFakeLivePhotosService: LPLivePhotosService {
    
    func fetchPhotos() -> Promise<[PHLivePhoto]> {
        return Promise { seal in
            var livePhotos = [PHLivePhoto]()

            let dg = DispatchGroup()
            let livePhotosResources = LPLivePhoto.mockPhotos()

            customQueue.async {
                livePhotosResources.forEach { res in
                    dg.enter()
                    self.generateLivePhoto(with: res, completion: { (livePhoto) in
                        livePhotos.append(livePhoto)
                        dg.leave()
                    })
                    dg.wait()
                }
            }
            
            customQueue.async {
                dg.notify(queue: .main) {
                    seal.fulfill(livePhotos)
                }
            }
        }
    }
    
    private func generateLivePhoto(with res: LPLivePhoto, completion: @escaping (PHLivePhoto) -> ()) {
        let imageURL = Bundle.main.url(forResource: res.imageUrl, withExtension: "jpg")!
        let videoURL = Bundle.main.url(forResource: res.videoUrl, withExtension: "mov")!

        LivePhoto.generate(
            from: imageURL,
            videoURL: videoURL,
            progress: { [res] percent in
                log.debug("generating file \(res.imageUrl) - \(res.videoUrl)", "\(percent)%")
            },
            completion: { livePhoto, resources in
                guard let livePhoto = livePhoto else { return }
                guard let resources = resources else { return }
                
                LivePhoto.saveToLibrary(resources, completion: { s in
                    log.info("isSaved - \(s)")
                    completion(livePhoto)
                })
            }
        )
    }
    
}
