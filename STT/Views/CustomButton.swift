//
//  CustomButton.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

protocol ButtonDelegate: AnyObject {
    func handle(_ button: Internship, indexPath: IndexPath)
}

class CustomButton: UIButton {
    
    // MARK: - Properties
    
    weak var delegate: ButtonDelegate?
    let internship: Internship
    var pressState: PressState
    var indexPath: IndexPath?
    
    static let height: CGFloat = 44
    lazy var width: CGFloat = {
        let spacing = SystemDesign.viewConfigurations.spacing
        let font = SystemDesign.Fonts.middle
        let width = internship.rawValue.width(height: CustomButton.height, font: font) + spacing * 4
        return width
    }()
    
    enum PressState {
        case pressed
        case normal
    }
    
    // MARK: - Lifecycle
    
    init(_ internship: Internship) {
        self.internship = internship
        self.pressState = PressState.normal
        super.init(frame: .zero)
        settupButton()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prirate methods
    
    private func settupButton() {
        setColors()
        setTitle(internship.rawValue, for: .normal)
        titleLabel?.font = SystemDesign.Fonts.middle
        layer.cornerRadius = 12
    }
    
    private func setColors() {
        switch pressState {
        case .pressed:
            backgroundColor = SystemDesign.Colors.black
            setTitleColor(.white, for: .normal)
        default:
            backgroundColor = SystemDesign.Colors.gray
            setTitleColor(SystemDesign.Colors.black, for: .normal)
        }
    }
    
    @objc private func buttonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.handle(internship, indexPath: indexPath)
    }
    
    // MARK: - Public methods
    
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func switchState() {
        if pressState == .pressed {
            pressState = .normal
            setColors()
        } else {
            pressState = .pressed
            setColors()
        }
    }
    
    func setUnselectedState() {
        pressState = .normal
        setColors()
    }
    
    func setSelectedState() {
        pressState = .pressed
        setColors()
    }
    
}
