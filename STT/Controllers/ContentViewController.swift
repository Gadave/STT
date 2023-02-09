//
//  ContentViewController.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class ContentViewController: UIViewController {

    // MARK: - Properties

//    private var selectedButtonElement: Int?
    lazy var customView = view as? ContentView
    var switchIndicator: Int = 10

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

        if let bottomCollectionLayout = customView.bottomCollectionView.collectionViewLayout as? BottomCollectionViewFlowLayout {
            bottomCollectionLayout.delegate = self
        }

        for button in customView.topButtons {
            button.delegate = self
        }
        for button in customView.bottomButtons {
            button.delegate = self
        }
    }

}

// MARK: - UICollectionViewDelegate protocol

extension ContentViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource protocol

extension ContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let customView = customView else { return .zero }

        if collectionView == customView.topCollectionView {
            return customView.topButtons.count
        } else {
            return customView.bottomButtons.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let customView = customView else { return UICollectionViewCell() }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let topButtons = customView.topButtons
        let bottonButtons = customView.bottomButtons

        if collectionView == customView.topCollectionView {
            let button = topButtons[indexPath.row]
            button.setIndexPath(indexPath)
            cell.configureWith(button)
            return cell
        } else {
            let button = bottonButtons[indexPath.row]
            cell.configureWith(button)
            button.setIndexPath(indexPath)
            return cell
        }
    }


}

// MARK: - UISheetPresentationControllerDelegate protocol

extension ContentViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let topButton = customView?.topButtons[indexPath.row] else {
            return CGSize()
        }
        return CGSize(width: topButton.getWidth(), height: CustomButton.height)
    }
}

// MARK: - BottomCollectionViewFlowLayoutDelegate protocol

extension ContentViewController: BottomCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForButtonAtIndexPath indexPath: IndexPath) -> CGSize {
        guard let bottomButton = customView?.bottomButtons[indexPath.row] else {
            return CGSize()
        }
        return CGSize(width: bottomButton.getWidth(), height: CustomButton.height)
    }

}

// MARK: - UISheetPresentationControllerDelegate protocol

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

// MARK: - ButtonDelegate protocol

extension ContentViewController: ButtonDelegate {
    func handle(_ button: Button, indexPath: IndexPath) {
        guard let customView = customView else { return }
        for item in customView.topButtons {
            if item.button != button {
                item.setUnselectedState()
            } else {
                item.switchState()
                guard let firstButtonIndexPath = customView.topButtons.first?.indexPath else { return }
                swapeCells(at: firstButtonIndexPath, and: indexPath)
            }
        }
        for item in customView.bottomButtons {
            if item.button != button {
                item.setUnselectedState()
            } else {
                item.switchState()
            }
        }
    }
}

// MARK: - Swipe actions

extension ContentViewController {
    func swapeCells(at indexPath1: IndexPath, and indexPath2: IndexPath) {
        guard let customView = customView else { return }

        customView.topButtons[indexPath1.item].indexPath = indexPath2
        customView.topButtons[indexPath2.item].indexPath = indexPath1

        customView.bottomButtons[indexPath1.item].indexPath = indexPath2
        customView.bottomButtons[indexPath2.item].indexPath = indexPath1

        let tempTop = customView.topButtons[indexPath1.item]
        customView.topButtons[indexPath1.item] = customView.topButtons[indexPath2.item]
        customView.topButtons[indexPath2.item] = tempTop

        let tempBottom = customView.bottomButtons[indexPath1.item]
        customView.bottomButtons[indexPath1.item] = customView.bottomButtons[indexPath2.item]
        customView.bottomButtons[indexPath2.item] = tempBottom


        customView.topCollectionView.performBatchUpdates({
            customView.topCollectionView.moveItem(at: indexPath1, to: indexPath2)
            customView.topCollectionView.moveItem(at: indexPath2, to: indexPath1)
        })
    }
}
