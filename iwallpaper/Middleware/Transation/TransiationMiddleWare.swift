//
//  Transiation.swift
//  iwallpaper
//
//  Created by Selim on 22.10.2024.
//

import Foundation
import QuartzCore

struct TransiationMiddleWare {
    
    
    func createTransiation() -> CATransition{
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        return transition
        
    }
    
}
