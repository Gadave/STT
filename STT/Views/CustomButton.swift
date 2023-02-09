//
//  CustomButton.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

protocol ButtonDelegate: AnyObject {
    func handle(_ button: Button)
}

class CustomButton: UIButton {

    // MARK: - Properties

    let button: Button
    static let height: CGFloat = 44
    var pressState: PressState

    enum PressState {
        case pressed
        case normal
    }

    weak var delegate: ButtonDelegate?

    // MARK: - Lifecycle

    init(_ button: Button) {
        self.button = button
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
        setTitle(button.rawValue, for: .normal)
        titleLabel?.font = SystemDesign.Fonts.middle
        layer.cornerRadius = 12
        frame.size = CGSize(width: getWidth(), height: CustomButton.height)
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

    private func switchState() {
        if pressState == .pressed {
            pressState = .normal
            setColors()
        } else {
            pressState = .pressed
            setColors()
        }
    }

    @objc private func buttonTapped() {
        delegate?.handle(button)
        switchState()
    }

    // MARK: - Public methods

    func setUnselectedState() {
        pressState = .normal
        setColors()
    }

    func getWidth() -> CGFloat {
        let spacing = SystemDesign.viewConfigurations.spacing
        return button.rawValue.width(height: CustomButton.height, font: SystemDesign.Fonts.middle) + spacing * 4
    }

}
