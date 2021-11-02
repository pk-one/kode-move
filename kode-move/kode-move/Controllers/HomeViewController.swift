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
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        let title = "PK"
        let colorTitle = "Move"
        let stringTitle = "\(title) \(colorTitle)"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringTitle)
        attributedString.setColor(color: .red, forText: colorTitle)
        label.font = UIFont.systemFont(ofSize: 26)
        label.attributedText = attributedString
        return label
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
        navigationItem.rightBarButtonItem = searchButton
       
    }
    
    @objc private func searchButton() {
        
    }

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
