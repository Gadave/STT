//
//  MainViewController.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setupContentVC()
    }
    
    // MARK: - Prirate methods
    
    private func setBackgroundImage() {
        let frame = CGRect(x: .zero,
                           y: .zero,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height * 2.5 / 3)
        let backgroundImage = UIImageView(frame: frame)
        backgroundImage.image = UIImage(named: "backgroungImage")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: .zero)
    }
    
    private func setupContentVC() {
        let contentVC = ContentViewController()
        contentVC.isModalInPresentation = true
        if let sheet = contentVC.sheetPresentationController {
            sheet.detents = [
                .customSmall,
                .customMiddle,
                .customBig
            ]
            sheet.preferredCornerRadius = 20
        }
        navigationController?.present(contentVC, animated: true)
    }
}
