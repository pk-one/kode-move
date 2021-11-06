//
//  WatchNowButtonTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 03.11.2021.
//

import UIKit

class WatchNowButtonTableViewCell: UITableViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Смотрите сейчас", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8841143847, green: 0.1051226184, blue: 0.2196062505, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.contentView.addSubview(button)
    }
}

//MARK: - setConstraint
extension WatchNowButtonTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
