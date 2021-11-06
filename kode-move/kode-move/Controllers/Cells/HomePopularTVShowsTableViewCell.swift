//
//  HomePopularTVShowsTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import UIKit

protocol HomePopularTVShowsTableViewCellDelegate: AnyObject {
    func tappedPopularTVShows(_ indexPath: Int?) -> Void
    func showError(_ error: Error?) -> Void
}

class HomePopularTVShowsTableViewCell: UITableViewCell {
    
    private var popularTVShowsCollectionView: UICollectionView!
    let networkService: NetworkService = NetworkServiceImplementation()
    var popularTVShows: PopularTVShowsModel? = nil
    weak var delegate: HomePopularTVShowsTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setDelegate()
        setConstraint()
        getPopularTVShows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPopularTVShows() {
        networkService.getPopularTVShows { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.delegate?.showError(error)
            case .success(let popularTVShowsArray):
                self.popularTVShows = popularTVShowsArray
                self.popularTVShowsCollectionView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsHomeTVShows.galleryMinimumLineSpacing
        popularTVShowsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        popularTVShowsCollectionView.register(PopularTVShowsCollectionViewCell.self, forCellWithReuseIdentifier: "PopularTVShowsCollectionViewCell")
        popularTVShowsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        popularTVShowsCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: ConstantsHomeTVShows.leftDistanceToCell,
            bottom: 0,
            right: ConstantsHomeTVShows.rightDistanceToCell)
        
        popularTVShowsCollectionView.showsVerticalScrollIndicator = false
        popularTVShowsCollectionView.showsHorizontalScrollIndicator = false
        popularTVShowsCollectionView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        self.addSubview(popularTVShowsCollectionView)
    }
    
    private func setDelegate() {
        popularTVShowsCollectionView.dataSource = self
        popularTVShowsCollectionView.delegate = self
    }
}

//MARK: - UICollectionViewDataSource
extension HomePopularTVShowsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularTVShows?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PopularTVShowsCollectionViewCell.self, for: indexPath)
        guard let popularTVShows = popularTVShows else { return UICollectionViewCell() }
        cell.configure(model: popularTVShows, indexPath: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomePopularTVShowsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedPopularTVShows(popularTVShows?.results[indexPath.row].id)

    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomePopularTVShowsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ConstantsHomeTVShows.galleryItemWidth, height: frame.height)
    }
}

//MARK: - setConstraint
extension HomePopularTVShowsTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            popularTVShowsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            popularTVShowsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            popularTVShowsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            popularTVShowsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            popularTVShowsCollectionView.heightAnchor.constraint(equalToConstant: 230)
            
        ])
    }
}

