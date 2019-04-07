//
//  File.swift
//  Smartwork
//
//  Created by Craig Newcomb on 3/31/19.
//  Copyright © 2019 Craig Newcomb. All rights reserved.
//

import Foundation

class LightController {
    
    enum panelType {
        case aurora, canvas
    }
    
    var panelType: panelType!
    var panelCount: Int = 1
    
    var orientation = "Unknown Data Type. Need to know more about how Nanoleaf describes orientation."
    var networkInfo = "Unknown Data Type. Need to know more about how Nanoleaf describes network info."
    
    init(panelType: panelType, panelCount: Int) {
        self.panelCount = panelCount
        self.panelType = panelType
    }
    
}
