//
//  HomeTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func tappedPopularMove(_ indexPath: Int?) -> Void
}

class HomeTableViewCell: UITableViewCell {

    private var popularMoviesCollectionView: UICollectionView!
        
    weak var delegate: HomeTableViewCellDelegate?
    
    var index: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setDelegate()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsHome.galleryMinimumLineSpacing
        popularMoviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        popularMoviesCollectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
        popularMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        popularMoviesCollectionView.contentInset = UIEdgeInsets(top: 0,
                                    left: ConstantsHome.leftDistanceToCell,
                                    bottom: 0,
                                    right: ConstantsHome.rightDistanceToCell)
        
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
extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PopularMovieCollectionViewCell.self, for: indexPath)
        cell.configure(image: "poster-1")
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedPopularMove(indexPath.row)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ConstantsHome.galleryItemWidth, height: frame.height)
    }
}


//MARK: - setConstraint
extension HomeTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            popularMoviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            popularMoviesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            popularMoviesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            popularMoviesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            popularMoviesCollectionView.heightAnchor.constraint(equalToConstant: 250)

        ])
    }
}

