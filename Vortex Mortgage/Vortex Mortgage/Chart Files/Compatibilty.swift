//
//  Compatibilty.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

#if !swift(>=4.2)
extension UIApplication {
  typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
}

extension NSAttributedString {
  typealias Key = NSAttributedStringKey
}
#endif

