//
//  ViewController.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let containerTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegate()
        setConstraint()
        setNavigationBar()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        view.addSubview(containerTableView)
    }
    
    private func setDelegate() {
        containerTableView.delegate = self
        containerTableView.dataSource = self
    }
    
    private func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let searchButton = createCustomBarButtonItem(selector: #selector(searchButton), title: "", image: "magnifyingglass", enabled: true)
        let logoButton = createCustomLogoBarButtonItem(image: "logo")
        navigationItem.leftBarButtonItem = logoButton
        navigationItem.rightBarButtonItem = searchButton
        
    }
    
    @objc private func searchButton() { }
    
    @objc private func noTapped() { }
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HomeTableViewCell.self, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.alpha = 0.8
        let label = UILabel()
        switch section {
        case 0:
            label.frame = CGRect(x: 10, y: 20, width: tableView.frame.width, height: 30)
            label.text = "Популярные фильмы"
        case 1:
            label.frame = CGRect(x: 10, y: -20, width: tableView.frame.width, height: 30)
            label.text = "Популярные сериалы"
        default: break
        }
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        default:
            return 20
        }
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    
}

extension HomeViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            containerTableView.topAnchor.constraint(equalTo: view.topAnchor),
            containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
