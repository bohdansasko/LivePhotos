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
//                    let imgName = res.imageUrl + ".jpg"
//                    let pathToImage = resourcePath + "/" + imgName
//
//                    let videoName = res.videoUrl + ".mov"
//                    let pathToVideo = resourcePath + "/" + videoName
//
                    let imageURL = URL(string: "/Users/tqos/Library/Developer/CoreSimulator/Devices/3CE1B1F4-A427-49EA-8236-F084170F2F36/data/Containers/Bundle/Application/1F09FB0A-4D87-4C74-B6DF-885EEC7BDA56/LivePhotos.app/709e38db7637c2bd20f35073a96a45cc.jpg")!
                    let videoURL = URL(string: "/Users/tqos/Library/Developer/CoreSimulator/Devices/3CE1B1F4-A427-49EA-8236-F084170F2F36/data/Containers/Bundle/Application/1F09FB0A-4D87-4C74-B6DF-885EEC7BDA56/LivePhotos.app/0e21e80d8b50a37f93caa380fe6d0a70.mov")!
                    
                    
                    photosGroup.enter()
                    
                    LivePhoto.generate(
                        from: imageURL,
                        videoURL: videoURL,
                        progress: { percent in
                            log.debug(percent)
                        },
                        completion: { livePhoto, _ in
                            defer { photosGroup.leave() }
                            guard let livePhoto = livePhoto else { return }
                            livePhotos.append(livePhoto)
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
