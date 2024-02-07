//
//  BaseViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func applyLocalization() {
    }
    
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        applyLocalization()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)

    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // End editing (dismiss keyboard) when tapping outside of the text field
        view.endEditing(true)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
