//
//  CustomCollectionViewCell.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomTableViewCell"
    private lazy var button = CustomButton(Internship.none)
    
    // MARK: Lyfecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        button =  CustomButton(Internship.none)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: CustomButton.height).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    // MARK: - Public methods
    
    func configureWith(_ button : CustomButton) {
        self.button = button
        self.button.frame.size = CGSize(width: self.button.width, height: CustomButton.height)
    }
    
}
