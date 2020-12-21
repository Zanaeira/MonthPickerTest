//
//  LocationsListViewController.swift
//  ipad-layout-testing
//
//  Created by Suhayl Ahmed on 27/10/2020.
//

import UIKit

class Sidebar: UIViewController {
    
    // (1) Layout (2) DataSource (3) Snapshot
    private lazy var layout = makeLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private lazy var dataSource = SidebarDataSourceFactory.makeDataSource(for: collectionView)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewAndDataSource()
        updateSidebar()
        setupAddLocationButton()
    }
    
    private func configureCollectionViewAndDataSource() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        // No need to set the collectionView's DataSource as that's done by makeDataSource(for: collectionView)
        dataSource.reorderingHandlers.canReorderItem = { _ in return true }
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func updateSidebar() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        applySectionSnapshot(to: dataSource, for: .overview)
        applySectionSnapshot(to: dataSource, for: .locations, with: Item.data(for: .locations))
        applySectionSnapshot(to: dataSource, for: .settings)
    }
    
    private func applySectionSnapshot(to dataSource: UICollectionViewDiffableDataSource<Section, Item>, for section: Section, with children: [Item]? = nil) {
        let hasChildren = children != nil
        
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        let sectionHeader = SectionHeader.header(for: section)
        let sectionItem = Item(title: sectionHeader.title, subtitle: "", image: sectionHeader.image, hasChildren: hasChildren)
        sectionSnapshot.append([sectionItem])
        
        if let children = children {
            sectionSnapshot.append(children, to: sectionItem)
            sectionSnapshot.expand([sectionItem])
        }
        
        dataSource.apply(sectionSnapshot, to: section)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.isEditing = editing
    }
    
    private func setupAddLocationButton() {
        let button = UIButton()
        let icon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        button.setImage(icon, for: .normal)
        view.addSubview(button)
        button.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
        button.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
    }
    
    @objc private func addLocation() {
        setEditing(false, animated: false)
        var snapshot = dataSource.snapshot(for: .locations)
        let item = Item(title: "Paris", subtitle: "Soon inshaa Allah...")
        snapshot.append([item])
        dataSource.apply(snapshot, to: .locations)
    }
    
}

/// Sidebar layout
extension Sidebar {
    
    private func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            
            var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
            
            if section == .locations {
                config.headerMode = .firstItemInSection
                config.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                    guard let self = self else { return nil }
                    guard indexPath.item != 0 else { return nil }
                    
                    return self.trailingSwipeActionDeleteForCell(at: indexPath)
                }
            }
            
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func trailingSwipeActionDeleteForCell(at indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let item = self.dataSource.itemIdentifier(for: indexPath)
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] (_, _, completion) in
                guard let self = self else {
                    completion(false)
                    return
                }
                
                if let item = item {
                    var snapshot = self.dataSource.snapshot()
                    snapshot.deleteItems([item])
                    self.dataSource.apply(snapshot)
                }
                
                completion(true)
            })
        ])
        
        return swipeActionConfiguration
    }
    
}
