//
//  CustomButton.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class CustomButton: UIButton {

    var titleText: String
    var pressState: PressState

    init(titleText: String) {
        self.titleText = titleText
        self.pressState = PressState.normal
        super.init(frame: .zero)
        settupButton()
        addTarget(self, action: #selector(switchState), for: .touchUpInside)
    }

    enum PressState {
        case pressed
        case normal
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func settupButton() {
        setColors()
        setTitle(titleText, for: .normal)
        titleLabel?.font = SystemDesign.Fonts.middle
        layer.cornerRadius = 12
        frame.size = CGSize(width: getWidth(), height: 44)
    }

    func getWidth() -> CGFloat {
        let spacing = SystemDesign.viewConfigurations.spacing
        return titleText.width(height: 44, font: SystemDesign.Fonts.middle) + spacing * 4
    }

    func setColors() {
        switch pressState {
        case .pressed:
            backgroundColor = SystemDesign.Colors.black
            setTitleColor(.white, for: .normal)
        default:
            backgroundColor = SystemDesign.Colors.gray
            setTitleColor(SystemDesign.Colors.black, for: .normal)
        }
    }

    @objc private func switchState() {
        if pressState == .pressed {
            pressState = .normal
            setColors()
        } else {
            pressState = .pressed
            setColors()
        }
    }
}
