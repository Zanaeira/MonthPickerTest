//
//  Section.swift
//  ipad-layout-testing
//
//  Created by Suhayl Ahmed on 30/10/2020.
//

import UIKit

extension Sidebar {
    
    enum Section: Int, CaseIterable, CustomStringConvertible {
        case overview, locations, settings
        
        var description: String {
            switch self {
                case .locations:
                    return "My locations"
                case .overview:
                    return "Overview"
                case .settings:
                    return "Settings"
            }
        }
    }
    
    struct SectionHeader {
        let title: String
        let image: UIImage?
        
        static func header(for section: Section) -> SectionHeader {
            let image: UIImage?
            switch section {
                case .locations: image = UIImage(systemName: "location")
                case .overview: image = UIImage(systemName: "globe")
                case .settings: image =  UIImage(systemName: "gear")
            }
            return .init(title: section.description, image: image)
        }
        
        private init(title: String, image: UIImage? = nil) {
            self.title = title
            self.image = image
        }
    }
    
}
