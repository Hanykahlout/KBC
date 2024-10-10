//
//  HUDMangaer.swift
//  FormApp
//
//  Created by Hany Alkahlout on 8/2/24.
//

import UIKit
import ProgressHUD

class HUDManager {
    
    static let shared = HUDManager()
    
    private init() {
        
        ProgressHUD.animationType = .circleDotSpinFade
        
    }
    
    func animate(_ message: String? = nil) {
        ProgressHUD.animate(message)
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
    }
    
    func dismiss() {
        ProgressHUD.dismiss()
        UIApplication.shared.windows.first?.isUserInteractionEnabled = true
    }
    
}


