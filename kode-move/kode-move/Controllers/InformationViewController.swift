//
//  SelectedContentViewController.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class InformationViewController: UIViewController {
    
    private let informationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(ContextInformationTableViewCell.self, forCellReuseIdentifier: "ContextInformationTableViewCell")
        tableView.register(CellForCollectionInformationTableViewCell.self, forCellReuseIdentifier: "CellForCollectionInformationTableViewCell")
        tableView.register(WatchNowButtonTableViewCell.self, forCellReuseIdentifier: "WatchNowButtonTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "poster-1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var testIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegate()
        setConstraint()
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(imageView)
        view.addSubview(gradientView)
        view.addSubview(informationTableView)
        
        DispatchQueue.main.async {
            let colorBottom = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
            self.gradientView.createGradientLayer(colorTop: .clear, colorBottom: colorBottom)
        }
    }
    
    private func setDelegate() {
        informationTableView.delegate = self
        informationTableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension InformationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.alpha = 1
        let label = UILabel()
        switch section {
        case 1:
            label.frame = CGRect(x: 10, y: 0, width: tableView.frame.width, height: 30)
            label.text = "Актеры"
        default: break
        }
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cellCollection = tableView.dequeueReusableCell(CellForCollectionInformationTableViewCell.self, for: indexPath)
            cellCollection.selectionStyle = .none
            return cellCollection
        } else if indexPath.section == 2 {
            let cellButton = tableView.dequeueReusableCell(WatchNowButtonTableViewCell.self, for: indexPath)
            cellButton.selectionStyle = .none
            return cellButton
        }
            
        let cell = tableView.dequeueReusableCell(ContextInformationTableViewCell.self, for: indexPath)
        switch indexPath.row {
        case 0:
            cell.configure(text: "Venom: Let There Be Carnage", color: .white, fontSize: 25, textAlignment: .center)
        case 1:
            cell.configure(text: "2021 • Фантастика, Боевик • 1 h 37 min", color: .lightGray, fontSize: 16, textAlignment: .center)
        case 2:
            cell.configure(text: "6.2", color: .yellow, fontSize: 18, textAlignment: .center)
        case 3:
            cell.configure(text: "Эдди живёт с симбиотом в своём теле уже давно и приспособился к быту. Однако ему придётся столкнуться со злодеем Клетусом Кэссиди, в котором обитает другой внеземной паразит по прозвищу Карнаж.", color: .lightGray, fontSize: 16, textAlignment: .natural)
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            let offset = (UIScreen.main.bounds.height * 0.3)
            return offset
        case 2:
            return 0
        default:
            return 30
        }
    }
}


//MARK: - UITableViewDelegate
extension InformationViewController: UITableViewDelegate {
    
}

//MARK: - setConstraint
extension InformationViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            informationTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            informationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            informationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            informationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            gradientView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}
