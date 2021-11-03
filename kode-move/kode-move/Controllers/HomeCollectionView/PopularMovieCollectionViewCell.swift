//
//  PopularMovieCollectionViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit
import Kingfisher

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Venom: Let There Be Carnage"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sep 30, 2021"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(posterImageView)
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
    }
    
    func configure(model: PopularMoviesModel, indexPath: IndexPath) {
        let host = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: host + model.results[indexPath.row].posterUrl) else { return }
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.results[indexPath.row].title
        let date = model.results[indexPath.row].date
        dateLabel.text = dateFormated(from: date)
    }
}

extension PopularMovieCollectionViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
}
