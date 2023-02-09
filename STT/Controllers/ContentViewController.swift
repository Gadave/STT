//
//  ContentViewController.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class ContentViewController: UIViewController {

    // MARK: - Properties

    private var selectedButtonElement: Int?
    lazy var customView = view as? ContentView

    // MARK: - Lifecycle

    override func loadView() {
        view = ContentView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subscribeOnCustomViewActions()
        setDelegates()
    }

    // MARK: - Prirate methods

    private func subscribeOnCustomViewActions() {
        customView?.didPressApplyButton = { [weak self] in
            let alertController = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
            let clouseAction = UIAlertAction(title: "Закрыть", style: .default)
            alertController.addAction(clouseAction)
            self?.present(alertController, animated: true)
        }
    }

    private func setDelegates() {
        guard let customView = customView else { return }

        sheetPresentationController?.delegate = self

        customView.topCollectionView.delegate = self
        customView.topCollectionView.dataSource = self
        customView.bottomCollectionView.delegate = self
        customView.bottomCollectionView.dataSource = self

        for button in customView.topButtons {
            button.delegate = self
        }
        for button in customView.bottomButtons {
            button.delegate = self
        }
    }

}

extension ContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let topButtons = customView?.topButtons,
              let bottomButtons = customView?.bottomButtons else {
            return .zero
        }
        if collectionView == customView?.topCollectionView {
            return topButtons.count
        } else {
            return bottomButtons.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == customView?.topCollectionView {
            guard let buttons =  customView?.topButtons else {
                return UICollectionViewCell()
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
                print("Error")
                return UICollectionViewCell()
            }
            let button = buttons[indexPath.row]
            cell.configureWith(button)
            return cell
        } else {
            guard let buttons =  customView?.bottomButtons else {
                return UICollectionViewCell()
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCustomCollectionViewCell.identifier, for: indexPath) as? SecondCustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            let button = buttons[indexPath.row]
            cell.configureWith(button)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let topButton = customView?.topButtons[indexPath.row],
              let bottomButton = customView?.bottomButtons[indexPath.row] else {
            return CGSize()
        }
        if collectionView == customView?.topCollectionView {
            return CGSize(width: topButton.getWidth(), height: CustomButton.height)
        } else {
            return CGSize(width: bottomButton.getWidth(), height: CustomButton.height)
        }
    }
}


extension ContentViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        guard let presentationController = presentationController as? UISheetPresentationController else { return }
        presentationController.animateChanges {
            if presentationController.selectedDetentIdentifier == UISheetPresentationController.Detent.customSmall.identifier {
                UIView.animate(withDuration: 0.5) {
                    self.customView?.bottomParagraphLabel.alpha = .zero
                    self.customView?.bottomCollectionView.alpha = .zero
                } completion: { _ in
                    self.customView?.bottomParagraphLabel.isHidden = true
                    self.customView?.bottomCollectionView.isHidden = true
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.customView?.bottomParagraphLabel.isHidden = false
                    self.customView?.bottomCollectionView.isHidden = false
                    self.customView?.bottomParagraphLabel.alpha = 1
                    self.customView?.bottomCollectionView.alpha = 1
                }
            }
        }
    }

}

extension ContentViewController: ButtonDelegate {
    func handle(_ button: Button) {
        guard let customView = customView else { return }
        for item in customView.topButtons {
            if item.button != button {
                item.setUnselectedState()
            }
        }
        for item in customView.bottomButtons {
            if item.button != button {
                item.setUnselectedState()
            }
        }
    }


}
