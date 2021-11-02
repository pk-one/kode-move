//
//  HomeTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    private var popularMoviesCollectionView = PopularMovieCollectionView()
    
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
        self.addSubview(popularMoviesCollectionView)
    }
    
}

extension HomeTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            popularMoviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            popularMoviesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            popularMoviesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            popularMoviesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            popularMoviesCollectionView.heightAnchor.constraint(equalToConstant: 250)

        ])
    }
}
