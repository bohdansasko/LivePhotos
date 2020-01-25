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

// MARK: - Help methods

private extension LPFakeLivePhotosService {
    
    func generateLivePhoto(with res: LPLiveAsset, completion: @escaping (PHLivePhoto) -> Void) {
        let imageURL = Bundle.main.url(forResource: res.name, withExtension: "JPG")!
        let videoURL = Bundle.main.url(forResource: res.name, withExtension: "mov")!

        LivePhoto.generate(
            from: imageURL,
            videoURL: videoURL,
            progress: { [res] percent in
                log.debug("generating file \(res.name)", "\(percent)%")
            },
            completion: { livePhoto, _ in
                guard let livePhoto = livePhoto else { return }
                completion(livePhoto)
            }
        )
    }
    
    
    func requestPhoto(with res: LPLiveAsset, completion: @escaping (PHLivePhoto?, Error?) -> Void) {
        let imageURL = Bundle.main.url(forResource: res.name, withExtension: "JPG")!
        let videoURL = Bundle.main.url(forResource: res.name, withExtension: "mov")!

        LivePhoto.requestLivePhoto(imageURL: imageURL, videoURL: videoURL, completion: { livePhoto, error in
            completion(livePhoto, error)
        })
    }
    
}

// MARK: - LPLivePhotosService

extension LPFakeLivePhotosService: LPLivePhotosService {
    
    func fetchLivePhotoAssets() -> [LPLiveAsset] {
        do {
            let plistURL = Bundle.main.url(
                forResource: LPConstants.kAssetsListFilename,
                withExtension: LPConstants.kAssetsListExt
            )!
            let plistDecoder = PropertyListDecoder()
            let data = try Data(contentsOf: plistURL)
            let value = try plistDecoder.decode([LPLiveAsset].self, from: data)
            return value
        } catch (let err) {
            log.error(err)
        }
        return []
    }
    
    func fetchPhotos() -> Promise<[PHLivePhoto]> {
        return Promise { seal in
            var livePhotos = [PHLivePhoto]()
            
            let assets = fetchLivePhotoAssets()
            let dg = DispatchGroup()
            
            var lvError: Error?
            
            customQueue.async {
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
                    
                    dg.wait()
                }
            }
            
            customQueue.async {
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
    
}
