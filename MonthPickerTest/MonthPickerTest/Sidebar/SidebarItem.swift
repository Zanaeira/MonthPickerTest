//
//  Item.swift
//  ipad-layout-testing
//
//  Created by Suhayl Ahmed on 30/10/2020.
//

import UIKit

extension Sidebar {
    
    struct Item: Hashable, CustomStringConvertible {
        private let id = UUID()
        let title, subtitle: String
        let image: UIImage?
        let hasChildren: Bool
        
        init(title: String, subtitle: String, image: UIImage? = nil, hasChildren: Bool = false) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
            self.hasChildren = hasChildren
        }
        
        var description: String {
            return "\(title)\n\(subtitle)"
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id
        }
        
        static func data(for section: Section) -> [Item] {
            switch section {
                case .locations:
                    return [Item(title: "London", subtitle: "Home"),
                            Item(title: "Dhaka", subtitle: "Home away from home"),
                            Item(title: "Makkah", subtitle: "If only..."),
                            Item(title: "New York", subtitle: "")]
                default:
                    return []
            }
        }
        
    }
    
}
