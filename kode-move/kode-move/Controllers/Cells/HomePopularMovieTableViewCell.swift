//
//  HomeTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

protocol HomePopularMovieTableViewCellDelegate: AnyObject {
    func tappedPopularMove(_ indexPath: Int?) -> Void
    func showError(_ error: Error?) -> Void
}

class HomePopularMovieTableViewCell: UITableViewCell {
    private var popularMoviesCollectionView: UICollectionView!
    let networkService: NetworkService = NetworkServiceImplementation()
    var popularMovies: PopularMoviesModel? = nil
    weak var delegate: HomePopularMovieTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setDelegate()
        setConstraint()
        getPopularMovies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPopularMovies() {
        networkService.getPopularMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.delegate?.showError(error)
            case .success(let popularMoviesArray):
                self.popularMovies = popularMoviesArray
                self.popularMoviesCollectionView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsHomeMovies.galleryMinimumLineSpacing
        popularMoviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        popularMoviesCollectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
        popularMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        popularMoviesCollectionView.contentInset = UIEdgeInsets(
                                    top: 0,
                                    left: ConstantsHomeMovies.leftDistanceToCell,
                                    bottom: 0,
                                    right: ConstantsHomeMovies.rightDistanceToCell)
        
        popularMoviesCollectionView.showsVerticalScrollIndicator = false
        popularMoviesCollectionView.showsHorizontalScrollIndicator = false
        popularMoviesCollectionView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        self.addSubview(popularMoviesCollectionView)
    }
    
    private func setDelegate() {
        popularMoviesCollectionView.dataSource = self
        popularMoviesCollectionView.delegate = self
    }   
}

//MARK: - UICollectionViewDataSource
extension HomePopularMovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PopularMovieCollectionViewCell.self, for: indexPath)
        guard let popularMovies = popularMovies else { return UICollectionViewCell() }
        cell.configure(model: popularMovies, indexPath: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomePopularMovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedPopularMove(indexPath.row)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomePopularMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ConstantsHomeMovies.galleryItemWidth, height: frame.height)
    }
}


//MARK: - setConstraint
extension HomePopularMovieTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            popularMoviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            popularMoviesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            popularMoviesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            popularMoviesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            popularMoviesCollectionView.heightAnchor.constraint(equalToConstant: 280)

        ])
    }
}

