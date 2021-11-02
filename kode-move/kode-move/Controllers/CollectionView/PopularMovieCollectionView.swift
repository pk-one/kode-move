//
//  PopularMovieCollectionView.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class PopularMovieCollectionView: UICollectionView {

    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        setDelegate()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
        translatesAutoresizingMaskIntoConstraints = false
        
        contentInset = UIEdgeInsets(top: 0,
                                    left: Constants.leftDistanceToCell,
                                    bottom: 0,
                                    right: Constants.rightDistanceToCell)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    private func setDelegate() {
        delegate = self
        dataSource = self
    }
}



//MARK: - UICollectionViewDataSource
extension PopularMovieCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PopularMovieCollectionViewCell.self, for: indexPath)
        cell.configure(image: "poster-1")
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension PopularMovieCollectionView: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularMovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: Constants.galleryItemWidth, height: frame.height)
    }
}
