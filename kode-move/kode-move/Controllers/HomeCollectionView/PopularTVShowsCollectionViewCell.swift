//
//  PopularTVShowsCollectionViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import UIKit
import Kingfisher
class PopularTVShowsCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Чаки"
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
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
    }
    
    func configure(model: PopularTVShowsModel, indexPath: IndexPath) {
        let host = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: host + model.results[indexPath.row].posterUrl) else { return }
        posterImageView.kf.setImage(with: url)
        nameLabel.text = model.results[indexPath.row].name
        let date = model.results[indexPath.row].date
        dateLabel.text = dateFormatedHome(from: date)
    }
}

//MARK: - setConstraint
extension PopularTVShowsCollectionViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
}
