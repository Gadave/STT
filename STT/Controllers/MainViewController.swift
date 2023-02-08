//
//  MainViewController.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setupContentVC()
    }

    private func setBackgroundImage() {
        let frame = CGRect(x: .zero,
                           y: .zero,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height * 2.5 / 3)
        let backgroundImage = UIImageView(frame: frame)
        backgroundImage.image = UIImage(named: "backgroungImage")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    private func setupContentVC() {
        let contentVC = ContentViewController()
        contentVC.isModalInPresentation = true

        navigationController?.present(contentVC, animated: true)
    }
}
