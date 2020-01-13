//
//  LPBaseViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

class LPBaseViewController: UIViewController {
    
    init<T: LPBaseViewController>(_ type: T.Type) {
        let nibName = xibName(from: type)
        super.init(nibName: nibName, bundle: nil)
    }
    
    @available(*, unavailable, message: "")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - LPErrorTraits

extension LPBaseViewController: LPErrorTraits {
    
}
