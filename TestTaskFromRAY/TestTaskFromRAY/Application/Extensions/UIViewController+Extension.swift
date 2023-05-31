//
//  UIViewController+Extension.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

extension UIViewController {
    func showAlert(_ message: String, _ title: String? = nil, okCompletion: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            DispatchQueue.main.async { okCompletion() }
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}
