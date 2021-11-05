//
//  SelectedContentTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class CellForCollectionInformationTableViewCell: UITableViewCell {
    
    private var castCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setDelegate()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsInformation.galleryMinimumLineSpacing
        castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCollectionViewCell")
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        castCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: ConstantsInformation.leftDistanceToCell,
            bottom: 0,
            right: ConstantsInformation.rightDistanceToCell)
        
        castCollectionView.showsVerticalScrollIndicator = false
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        
        self.addSubview(castCollectionView)
    }
    
    private func setDelegate() {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
}

//MARK: - UICollectionViewDataSource
extension CellForCollectionInformationTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CastCollectionViewCell.self, for: indexPath)
        cell.configure(image: "cast-1")
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CellForCollectionInformationTableViewCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CellForCollectionInformationTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ConstantsInformation.galleryItemWidth, height: frame.height)
    }
}

//MARK: - setConstraint
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
