//
//  UIApplicaiton.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/3/10.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        //UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
