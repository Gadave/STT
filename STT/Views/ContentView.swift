//
//  ContentView.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class ContentView: UIView {

    // MARK: - Properties

    var didPressApplyButton: (() -> Void)?

    private(set) lazy var topButtons = [CustomButton]()
    private(set) lazy var bottomButtons = [CustomButton]()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.font = SystemDesign.Fonts.huge
        label.textColor = SystemDesign.Colors.black
        return label
    }()

    private lazy var topParagraphLabel: UILabel = {
        let label = UILabel()
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        label.numberOfLines = .zero
        label.font = SystemDesign.Fonts.small
        label.textColor = SystemDesign.Colors.gray2
        return label
    }()

    private lazy var bottomContainer = UIView()

    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = SystemDesign.Fonts.small
        button.backgroundColor = SystemDesign.Colors.black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Хочешь к нам?"
        label.font = SystemDesign.Fonts.small
        label.textColor = SystemDesign.Colors.gray2
        return label
    }()

    lazy var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = SystemDesign.viewConfigurations.spacing
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.isScrollEnabled = true
        return view
    }()

    lazy var bottomCollectionView: UICollectionView = {
        let layout = BottomCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        view.isHidden = true
        return view
    }()

    lazy var bottomParagraphLabel: UILabel = {
        let label = UILabel()
        label.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        label.numberOfLines = .zero
        label.font = SystemDesign.Fonts.small
        label.textColor = SystemDesign.Colors.gray2
        label.isHidden = true
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setViewsConstraints()
        setFixedViewsConstraints()
        setButtons()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setButtons() {
        topButtons = Button.allCases.map( { CustomButton($0) } )
        bottomButtons = Button.allCases.map( { CustomButton($0) } )
    }

    @objc private func applyButtonTapped() {
        didPressApplyButton?()
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(topParagraphLabel)
        addSubview(bottomParagraphLabel)

        addSubview(topCollectionView)
        addSubview(bottomCollectionView)

        addSubview(bottomContainer)
        bottomContainer.addSubview(applyButton)
        bottomContainer.addSubview(questionLabel)
    }

    private func setViewsConstraints() {
        let padding = SystemDesign.viewConfigurations.padding
        let spacing = SystemDesign.viewConfigurations.spacing
        let buttonHeight = CustomButton.height

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: spacing * 2).isActive = true

        topParagraphLabel.translatesAutoresizingMaskIntoConstraints = false
        topParagraphLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        topParagraphLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        topParagraphLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: spacing).isActive = true

        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        topCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        topCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topCollectionView.topAnchor.constraint(equalTo: topParagraphLabel.bottomAnchor,constant: spacing).isActive = true

        bottomParagraphLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomParagraphLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        bottomParagraphLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        bottomParagraphLabel.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor,constant: spacing * 2).isActive = true

        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.heightAnchor.constraint(equalToConstant: buttonHeight * 2 + spacing * 2).isActive = true
        bottomCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        bottomCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomCollectionView.topAnchor.constraint(equalTo: bottomParagraphLabel.bottomAnchor,constant: spacing).isActive = true
    }

    private func setFixedViewsConstraints() {
        let padding = SystemDesign.viewConfigurations.padding
        let sectionHeight: CGFloat = 60
        let applyButtonWidth: CGFloat = 220

        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding * 2).isActive = true
        bottomContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: applyButton.leadingAnchor).isActive = true
        questionLabel.centerYAnchor.constraint(equalTo: applyButton.centerYAnchor).isActive = true

        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.widthAnchor.constraint(equalToConstant: applyButtonWidth).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor).isActive = true
    }
}
