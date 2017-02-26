//
//  CropViewController.swift
//  CropViewController
//
//  Created by Alexsander Khitev on 2/26/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {
    
    // MARK: - Data
    
    var image: UIImage!
    var croppingStyle = TOCropViewCroppingStyle._default
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Settings
        setupSettings()
    }

    private func setupSettings() {
        definesPresentationContext = true
    }

}
