//
//  SidebarDataSource.swift
//  ipad-layout-testing
//
//  Created by Suhayl Ahmed on 30/10/2020.
//

import UIKit

class SidebarDataSourceFactory {
    
    typealias Section = Sidebar.Section
    typealias SectionHeader = Sidebar.SectionHeader
    typealias Item = Sidebar.Item
    
    static func makeDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Item> {
        return .init(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
                case .locations:
                    if item.hasChildren {
                        return collectionView.dequeueConfiguredReusableCell(using: self.configuredHeaderCell(), for: indexPath, item: SectionHeader.header(for: section))
                    }
                    return collectionView.dequeueConfiguredReusableCell(using: self.configuredLocationCell(), for: indexPath, item: item)
                default:
                    return collectionView.dequeueConfiguredReusableCell(using: self.configuredListCell(), for: indexPath, item: item)
            }
        }
    }
    
    static private func configuredHeaderCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, SectionHeader> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, SectionHeader>() { (cell, indexPath, headerItem) in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            content.image = headerItem.image
            cell.contentConfiguration = content
            
            cell.accessories = [.outlineDisclosure()]
        }
    }
    
    static private func configuredLocationCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Item>() { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.secondaryText = item.subtitle
            content.image = item.image
            cell.contentConfiguration = content
            
            cell.accessories = [.delete(displayed: .whenEditing), .reorder(displayed: .whenEditing)]
        }
    }
    
    static private func configuredListCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Item>() { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.secondaryText = item.subtitle
            content.image = item.image
            cell.contentConfiguration = content
        }
    }
    
}
