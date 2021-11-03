//
//  SelectedContentTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class CellForCollectionInformationTableViewCell: UITableViewCell {
    
    private var castCollectionView = CastCollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(castCollectionView)
    }
    
}

extension CellForCollectionInformationTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            castCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            castCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            castCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            castCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            castCollectionView.heightAnchor.constraint(equalToConstant: 100)

        ])
    }
}
