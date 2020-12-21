//
//  DetailsViewController.swift
//  MonthPickerTest
//
//  Created by Suhayl Ahmed on 20/12/2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let monthPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        setupViews()
    }
    
    
    private func setupViews() {
        view.addSubview(monthPicker)
        monthPicker.datePickerMode = .date
        
        monthPicker.centerInSuperview()
    }

    
}
