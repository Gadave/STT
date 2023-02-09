//
//  CustomCollectionViewCell.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomTableViewCell"
    var button: CustomButton?

    // MARK: Lyfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        button?.removeFromSuperview()
        button = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let button = button else { return }
        button.frame.origin = CGPoint(x: 0, y: 0)
    }

    // MARK: - Public methods

    func configureWith(_ button : CustomButton) {
        self.button = button
        contentView.addSubview(button)
    }

}
