//
//  ContentViewController.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class ContentViewController: UIViewController {

    // MARK: - Properties

    lazy var customView = view as? ContentView
    private var selectedItem: String?

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
            if self?.selectedItem != nil {
                let alertController = UIAlertController(title: "Поздравляем!", message: "Вы выбрали направление: \(self?.selectedItem ?? "")\nВаша заявка успешно отправлена!", preferredStyle: .alert)
                let clouseAction = UIAlertAction(title: "Закрыть", style: .default)
                alertController.addAction(clouseAction)
                self?.present(alertController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Не выбрано направление", message: "Выберите направление чтобы отправить заявку.", preferredStyle: .alert)
                let clouseAction = UIAlertAction(title: "Закрыть", style: .default)
                alertController.addAction(clouseAction)
                self?.present(alertController, animated: true)
            }
        }
    }

    private func setDelegates() {
        guard let customView = customView else { return }

        sheetPresentationController?.delegate = self

        customView.topCollectionView.delegate = self
        customView.topCollectionView.dataSource = self
        customView.bottonCollectionView.delegate = self
        customView.bottonCollectionView.dataSource = self

        if let bottonCollectionLayout = customView.bottonCollectionView.collectionViewLayout as? BottonCollectionViewFlowLayout {
            bottonCollectionLayout.delegate = self
        }

        for button in customView.topButtons {
            button.delegate = self
        }
        for button in customView.bottonButtons {
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
            return customView.bottonButtons.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let customView = customView,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let topButtons = customView.topButtons
        let bottonButtons = customView.bottonButtons

        if collectionView == customView.topCollectionView {
            let button = topButtons[indexPath.row]
            button.setIndexPath(indexPath)
            cell.configureWith(button)
            return cell
        } else {
            let button = bottonButtons[indexPath.row]
            cell.configureWith(button)
            setButtonVisibility(with: indexPath, isVisble: checkBottonButtonScreenPosition(at: indexPath))
            button.setIndexPath(indexPath)
            return cell
        }
    }


}

// MARK: - UICollectionViewDelegateFlowLayout protocol

extension ContentViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let topButton = customView?.topButtons[indexPath.row] else {
            return CGSize()
        }
        return CGSize(width: topButton.width, height: CustomButton.height)
    }


}

// MARK: - BottomCollectionViewFlowLayoutDelegate protocol

extension ContentViewController: BottonCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForButtonAtIndexPath indexPath: IndexPath) -> CGSize {
        guard let bottomButton = customView?.bottonButtons[indexPath.row] else {
            return CGSize()
        }
        return CGSize(width: bottomButton.width, height: CustomButton.height)
    }


}
// MARK: - UISheetPresentationControllerDelegate protocol

extension ContentViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        guard let presentationController = presentationController as? UISheetPresentationController else { return }
        presentationController.animateChanges {
            if presentationController.selectedDetentIdentifier == UISheetPresentationController.Detent.customSmall.identifier {
                UIView.animate(withDuration: 0.3) {
                    self.customView?.bottonParagraphLabel.alpha = .zero
                    self.customView?.bottonCollectionView.alpha = .zero
                } completion: { _ in
                    self.customView?.bottonParagraphLabel.isHidden = true
                    self.customView?.bottonCollectionView.isHidden = true
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.customView?.bottonParagraphLabel.isHidden = false
                    self.customView?.bottonCollectionView.isHidden = false
                    self.customView?.bottonParagraphLabel.alpha = 1
                    self.customView?.bottonCollectionView.alpha = 1
                }
            }
        }
    }


}

// MARK: - ButtonDelegate protocol

extension ContentViewController: ButtonDelegate {
    func handle(_ internship: Internship, indexPath: IndexPath) {
        guard let customView = customView else { return }
        for item in customView.topButtons {
            if item.internship != internship {
                item.setUnselectedState()
            } else {
                item.switchState()
                guard let firstButtonIndexPath = customView.topButtons.first?.indexPath else { return }
                swapeTopCells(at: firstButtonIndexPath, and: indexPath)
                customView.topCollectionView.scrollToItem(at: IndexPath(row: .zero, section: .zero), at: .left, animated: true)
                setSecetedItem(item.internship.rawValue)
            }
        }
        for item in customView.bottonButtons {
            if item.internship != internship {
                item.setUnselectedState()
            } else {
                item.switchState()
            }
        }
    }

    func setSecetedItem(_ item: String) {
        if selectedItem == nil || selectedItem != item {
            selectedItem = item
        } else {
            selectedItem = nil
        }
    }

    func swapeTopCells(at indexPath1: IndexPath, and indexPath2: IndexPath) {
        guard let customView = customView else { return }

        customView.topButtons[indexPath1.item].indexPath = indexPath2
        customView.topButtons[indexPath2.item].indexPath = indexPath1

        let tempTop = customView.topButtons[indexPath1.item]
        customView.topButtons[indexPath1.item] = customView.topButtons[indexPath2.item]
        customView.topButtons[indexPath2.item] = tempTop

        customView.topCollectionView.performBatchUpdates({
            customView.topCollectionView.moveItem(at: indexPath1, to: indexPath2)
            customView.topCollectionView.moveItem(at: indexPath2, to: indexPath1)
        })
    }


}

// MARK: - UIScrollViewDelegate protocol

extension ContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let bottonCollectionView = customView?.bottonCollectionView else { return }
        if scrollView == bottonCollectionView {
            let visibleIndexPaths = bottonCollectionView.indexPathsForVisibleItems
            for indexPath in visibleIndexPaths {
                setButtonVisibility(with: indexPath, isVisble: checkBottonButtonScreenPosition(at: indexPath))
            }
        }
    }

    func checkBottonButtonScreenPosition(at indexPath: IndexPath) -> Bool {
        guard let bottonCollectionView = customView?.bottonCollectionView else { return false }
        let availableWidth = UIScreen.main.bounds.width - SystemDesign.viewConfigurations.padding
        let scrollXOffset = bottonCollectionView.contentOffset.x
        let attributes = bottonCollectionView.layoutAttributesForItem(at: indexPath)
        guard let xPositionInCollectionView = attributes?.frame.origin.x,
              let itemWidth = attributes?.frame.width else {
            return false
        }
        let maxX = xPositionInCollectionView + itemWidth - scrollXOffset
        let isOutOfScreen = maxX > availableWidth
        return isOutOfScreen
    }

    func setButtonVisibility(with indexPath: IndexPath, isVisble: Bool) {
        if isVisble {
            UIView.animate(withDuration: 0.3) {
                self.customView?.bottonButtons[indexPath.item].alpha = .zero
            } completion: { _ in
                self.customView?.bottonButtons[indexPath.item].isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.customView?.bottonButtons[indexPath.item].isHidden = false
                self.customView?.bottonButtons[indexPath.item].alpha = 1
            }
        }
    }


}
