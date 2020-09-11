//
//  UIViewControllerExtensions.swift
//  TestTask
//
//  Created by Ruslan on 11.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = "", message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ок", style: .default, handler: handler)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
