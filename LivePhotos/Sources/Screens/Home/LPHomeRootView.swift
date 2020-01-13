//
//  LPHomeRootView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import SnapKit

final class LPHomeRootView: LPBaseView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
}

// MARK: - Setup

private extension LPHomeRootView {
        
    func setupLayout() {
        backgroundColor = .gray
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
