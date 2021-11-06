//
//  ContextInformationTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class ContextInformationTableViewCell: UITableViewCell {

    private let contextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
        self.addSubview(contextLabel)
    }
    
    func configure(text: String, color: UIColor, fontSize: CGFloat, textAlignment: NSTextAlignment) {
        contextLabel.text = text
        contextLabel.textColor = color
        contextLabel.font = UIFont.systemFont(ofSize: fontSize)
        contextLabel.textAlignment = textAlignment
    }
}

//MARK: - setConstraint
extension ContextInformationTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            contextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            contextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}
