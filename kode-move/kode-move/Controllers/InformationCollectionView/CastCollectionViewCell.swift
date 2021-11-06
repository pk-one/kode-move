//
//  CastCollectionViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tom Hardy"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.text = "Eddie Brock / Venom"
        label.font = UIFont.systemFont(ofSize: 10)
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
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(characterLabel)
    }
    
    func configure(model: CastModel, indexPath: IndexPath) {
        let host = "https://image.tmdb.org/t/p/w500"
        if model.cast[indexPath.row].avatar == nil {
            profileImageView.image = UIImage(named: "no-avatar")
        } else {
            guard let path = model.cast[indexPath.row].avatar else { return }
            profileImageView.kf.setImage(with: URL(string: host + path))
        }
        nameLabel.text = model.cast[indexPath.row].name
        characterLabel.text = model.cast[indexPath.row].character
    }
}

//MARK: - setConstraint
extension CastCollectionViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            characterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            characterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
}
