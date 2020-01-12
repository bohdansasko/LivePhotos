//
//  UIViewController+Ext.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

func xibName<T: UIViewController>(from type: T.Type) -> String {
    let className = String(describing: type)
    return className
}
