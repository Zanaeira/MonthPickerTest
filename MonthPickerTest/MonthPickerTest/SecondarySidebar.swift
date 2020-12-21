//
//  SecondarySidebar.swift
//  MonthPickerTest
//
//  Created by Suhayl Ahmed on 20/12/2020.
//

import UIKit

class SecondarySidebar: UICollectionViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.delegate = self
        
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.id, for: indexPath)
        
        cell.backgroundColor = .systemGray6
        
        return cell
    }
    
}

extension SecondarySidebar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 75)
    }
    
}

private class DateCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let id = "DateCell"
    
    private let dateLabel = UILabel(text: "20 Dec 2020", font: .boldSystemFont(ofSize: 16))
    private var salahTimingsLabels = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        loadSalahLabels()
        setupStackViews()
    }
    
    private func loadSalahLabels() {
//        salahTimingsLabels.append(.init(text: "Fajr: 6:28am", font: .systemFont(ofSize: 14)))
//        salahTimingsLabels.append(.init(text: "Zuhr: 11:58pm", font: .systemFont(ofSize: 14)))
//        salahTimingsLabels.append(.init(text: "'Asr: 14:08pm", font: .systemFont(ofSize: 14)))
//        salahTimingsLabels.append(.init(text: "Maghrib: 16:08pm", font: .systemFont(ofSize: 14)))
//        salahTimingsLabels.append(.init(text: "'Ishā: 17:58pm", font: .systemFont(ofSize: 14)))
        salahTimingsLabels.append(.init(text: "6:28am", font: .systemFont(ofSize: 14)))
        salahTimingsLabels.append(.init(text: "11:58pm", font: .systemFont(ofSize: 14)))
        salahTimingsLabels.append(.init(text: "14:08pm", font: .systemFont(ofSize: 14)))
        salahTimingsLabels.append(.init(text: "16:08pm", font: .systemFont(ofSize: 14)))
        salahTimingsLabels.append(.init(text: "17:58pm", font: .systemFont(ofSize: 14)))
    }
    
    private func setupViews() {
        
        let topHorizontalStackView = UIStackView(arrangedSubviews: [salahTimingsLabels[0],salahTimingsLabels[1],salahTimingsLabels[2]])
        let bottomHorizontalStackView = UIStackView(arrangedSubviews: [salahTimingsLabels[3],salahTimingsLabels[4]])
        
        topHorizontalStackView.backgroundColor = .systemOrange
        bottomHorizontalStackView.backgroundColor = .systemYellow
        
//        let horizontalStack = UIStackView(arrangedSubviews: salahTimingsLabels)
        let verticalStack = UIStackView(arrangedSubviews: [topHorizontalStackView, bottomHorizontalStackView])
        verticalStack.axis = .vertical
        
        verticalStack.backgroundColor = .systemBlue
        
        verticalStack.distribution = .fillEqually
        
        verticalStack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        
        let mainHorizontalStackView = UIStackView(arrangedSubviews: [dateLabel, verticalStack])
        
        mainHorizontalStackView.backgroundColor = .systemRed
        
        addSubview(mainHorizontalStackView)
        mainHorizontalStackView.fillSuperview()
    }
    
    private func setupStackViews() {
        let horizontalStack = UIStackView(arrangedSubviews: salahTimingsLabels)
        
        horizontalStack.distribution = .fillEqually
        horizontalStack.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: -10)
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        
        let verticalStack = UIStackView(arrangedSubviews: [dateLabel, horizontalStack])
        
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        
//        horizontalStack.backgroundColor = .systemRed
//        verticalStack.backgroundColor = .systemYellow
        
        addSubview(verticalStack)
        verticalStack.fillSuperview()
    }
    
}
