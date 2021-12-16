//
//  PopupView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI
import UIKit

extension View {
    func popup<PopupView: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> PopupView) -> some View {
        let topViewController = topViewController()
        
        if isPresented.wrappedValue {
            let alertVC = PopupHostedViewController(isPresented: isPresented, rootView: content())
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.view.backgroundColor = UIColor.clear
            alertVC.modalTransitionStyle = .crossDissolve
            
            topViewController?.present(alertVC, animated: true, completion: nil)
        } else {
            topViewController?.presentedViewController?.dismiss(animated: true)
        }

        return self
    }

    private func topViewController(baseVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = baseVC as? UINavigationController {
            return topViewController(baseVC: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(baseVC: selected)
            }
        }
        if let presented = baseVC?.presentedViewController {
            return topViewController(baseVC: presented)
        }
        return baseVC
    }
}
