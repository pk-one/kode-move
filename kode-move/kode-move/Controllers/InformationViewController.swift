//
//  SelectedContentViewController.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit
import Kingfisher

class InformationViewController: UIViewController {
    
    private let networkService: NetworkService = NetworkServiceImplementation()
    
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
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var idMovie: Int? = 0
    var idTVShow: Int? = 0
    var movie: MovieModel? = nil
    var tvShow: TVShowModel? = nil
    var urlSite: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            let colorBottom = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
            self.gradientView.createGradientLayer(colorTop: .clear, colorBottom: colorBottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegate()
        setConstraint()
        checkID()
    }
    
    private func checkID() {
        if idMovie != 0 {
            getMovie()
        } else {
            getTVShow()
        }
    }
    
    private func getMovie() {
        guard let idMovie = idMovie else { return }
        networkService.getMovie(id: idMovie) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.show(error: error)
            case .success(let movie):
                self.movie = movie
                self.informationTableView.reloadData()
            }
        }
    }
    
    private func getTVShow() {
        guard let idTVShow = idTVShow else { return }
        networkService.getTVShow(id: idTVShow) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.show(error: error)
            case .success(let tvShow):
                self.tvShow = tvShow
                self.informationTableView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(backgroundPosterImageView)
        view.addSubview(gradientView)
        view.addSubview(informationTableView)
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
        let host = "https://image.tmdb.org/t/p/w500"
        
        if indexPath.section == 1 {
            let cellCollection = tableView.dequeueReusableCell(CellForCollectionInformationTableViewCell.self, for: indexPath)
            cellCollection.delegate = self
            cellCollection.idMovie = idMovie
            cellCollection.idTVShow = idTVShow
            cellCollection.selectionStyle = .none
            return cellCollection
        } else if indexPath.section == 2 {
            let cellButton = tableView.dequeueReusableCell(WatchNowButtonTableViewCell.self, for: indexPath)
            cellButton.button.addTarget(self, action: #selector(tappedWatchNow(_:)), for: .touchUpInside)
            if idMovie != 0 {
                urlSite = movie?.homepage ?? ""
            } else {
                urlSite = tvShow?.homepage ?? ""
            }
            cellButton.selectionStyle = .none
            return cellButton
        }
        
        let cell = tableView.dequeueReusableCell(ContextInformationTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        if idMovie != 0 {
            guard let posterURL = movie?.backgroundPoster else { return UITableViewCell() }
            let url = URL(string: host + posterURL)
            backgroundPosterImageView.kf.setImage(with: url)
            switch indexPath.row {
            case 0:
                cell.configure(text: movie?.title ?? "", color: .white, fontSize: 25, textAlignment: .center)
            case 1:
                cell.configure(text: "\(dateFormatedInfo(from: movie?.date ?? "")) • \(movie?.genres.first?.name ?? "") • \(timeFormatter(minutes:  movie?.runtime ?? 0))", color: .lightGray, fontSize: 16, textAlignment: .center)
            case 2:
                cell.configure(text: "Рейтинг: \(movie?.rating ?? 0.0)" , color: .yellow, fontSize: 16, textAlignment: .center)
            case 3:
                cell.configure(text: movie?.description ?? "", color: .lightGray, fontSize: 16, textAlignment: .natural)
            default:
                break
            }
            return cell
        } else {
            guard let posterURL = tvShow?.backgroundPoster else { return UITableViewCell() }
            let url = URL(string: host + posterURL)
            backgroundPosterImageView.kf.setImage(with: url)
            
            switch indexPath.row {
            case 0:
                cell.configure(text: tvShow?.name ?? "", color: .white, fontSize: 25, textAlignment: .center)
            case 1:
                cell.configure(text: "\(dateFormatedInfo(from: tvShow?.date ?? "")) • \(tvShow?.genres.first?.name ?? "") • \(timeFormatter(minutes: tvShow?.runtime[0] ?? 0))", color: .lightGray, fontSize: 16, textAlignment: .center)
            case 2:
                cell.configure(text: "Рейтинг: \(tvShow?.rating ?? 0.0)" , color: .yellow, fontSize: 16, textAlignment: .center)
            case 3:
                cell.configure(text: tvShow?.description ?? "", color: .lightGray, fontSize: 16, textAlignment: .natural)
            default:
                break
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            let offset = (UIScreen.main.bounds.height * 0.4)
            return offset
        case 2:
            return 0
        default:
            return 30
        }
    }
    
    @objc func tappedWatchNow(_ sender: UIButton) {
        if let url = URL(string: urlSite) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}


//MARK: - UITableViewDelegate
extension InformationViewController: UITableViewDelegate {
    
}

//MARK: - CellForCollectionInformationTableViewCellDelegate
extension InformationViewController: CellForCollectionInformationTableViewCellDelegate {
    func showError(_ error: Error?) {
        guard let error = error else { return }
        show(error: error)
    }
}

//MARK: - setConstraint
extension InformationViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            informationTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            informationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            informationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            informationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            backgroundPosterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundPosterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundPosterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundPosterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            gradientView.topAnchor.constraint(equalTo: backgroundPosterImageView.bottomAnchor, constant: 0),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}
