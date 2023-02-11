//
//  BottonCollectionViewFlowLayout.swift
//  STT
//
//  Created by Георгий Давыденко on 09.02.2023.
//

import UIKit

protocol BottonCollectionViewFlowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, sizeForButtonAtIndexPath indexPath: IndexPath) -> CGSize
}

class BottonCollectionViewFlowLayout: UICollectionViewFlowLayout {

    weak var delegate: BottonCollectionViewFlowLayoutDelegate?

    private let numberOfRows = 2
    private let cellSpacing: CGFloat = SystemDesign.viewConfigurations.spacing

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentWidth: CGFloat = .zero

    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return .zero
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }

        let columnHeight = (contentHeight - cellSpacing) / CGFloat(numberOfRows)
        var yOffset: [CGFloat] = []
        for row in 0..<numberOfRows {
            if row == 0 {
                yOffset.append(CGFloat(row) * columnHeight)
            } else {
                yOffset.append(CGFloat(row) * columnHeight + cellSpacing)
            }
        }

        var row = 0
        var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfRows)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            guard let buttonSize = delegate?.collectionView(collectionView, sizeForButtonAtIndexPath: indexPath) else { return }
            let width = buttonSize.width
            let frame = CGRect(x: xOffset[row],
                               y: yOffset[row],
                               width: width,
                               height: columnHeight)
            let insetFrame = frame.insetBy(dx: .zero, dy: .zero)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width + cellSpacing

            row = row < (numberOfRows - 1) ? (row + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }


}
