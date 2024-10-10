//
//  Alerts.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/10/24.
//

import UIKit


class Alerts{
    
    
    static let shared = Alerts()
    
    private init() {}
    
    
    func show(title:String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
        }))
        getCurrentViewController()?.present(alert, animated: true)
    }
    
    func getCurrentViewController() -> UIViewController? {
        
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return nil
        }
        return getVisibleViewController(from: rootViewController)
    }

    func getVisibleViewController(from viewController: UIViewController) -> UIViewController? {

        if let presentedViewController = viewController.presentedViewController {
            return getVisibleViewController(from: presentedViewController)
        }
        

        if let navigationController = viewController as? UINavigationController {
            return getVisibleViewController(from: navigationController.visibleViewController ?? navigationController)
        }
        

        if let tabBarController = viewController as? UITabBarController {
            return getVisibleViewController(from: tabBarController.selectedViewController ?? tabBarController)
        }
        

        return viewController
    }

    
}

