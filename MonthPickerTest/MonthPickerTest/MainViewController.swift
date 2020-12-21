//
//  MainViewController.swift
//  MonthPickerTest
//
//  Created by Suhayl Ahmed on 20/12/2020.
//

import UIKit

class MainViewController: UISplitViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    init() {
        super.init(style: .tripleColumn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        let sidebar = Sidebar()
        let secondarySidebar = SecondarySidebar()
        let detailsVC = DetailsViewController()
        
        self.preferredDisplayMode = .twoBesideSecondary
        
        self.setViewController(sidebar, for: .primary)
        self.setViewController(secondarySidebar, for: .supplementary)
        self.setViewController(detailsVC, for: .secondary)
    }
    
}
