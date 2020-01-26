//
//  LPHomeDependencyContainer.swift
//  LivePhotos
//
//  Created by Office Mac on 1/26/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

final class LPHomeDependencyContainer {

}

// MARK: -

extension LPHomeDependencyContainer {

    func makeHomeViewController() -> LPHomeViewController {
        let api = LPLocalLivePhotosService()
        let storage = LPLocalPhotosStorage()
        let repository = LPLocalPhotosRepository(photosAPI: api, storage: storage)
        let viewModel = LPHomeViewModel(photosRepository: repository)
        
        let homeViewController = LPHomeViewController(viewModel: viewModel)
        return homeViewController
    }

}
