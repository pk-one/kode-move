//
//  SelectedContentTableViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

protocol CellForCollectionInformationTableViewCellDelegate: AnyObject {
    func showError(_ error: Error?) -> Void
}

class CellForCollectionInformationTableViewCell: UITableViewCell {
    
    private let networkService: NetworkService = NetworkServiceImplementation()
    private var castCollectionView: UICollectionView!
    private var isLoaded = false
    
    var idMovie: Int? = 0
    var idTVShow: Int? = 0
    var casts: CastModel? = nil

    weak var delegate: CellForCollectionInformationTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
        setDelegate()
        setConstraint()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.getCastsByID()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsInformation.galleryMinimumLineSpacing
        castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCollectionViewCell")
        castCollectionView.register(ShimmerCollectionViewCell.self, forCellWithReuseIdentifier: "ShimmerCollectionViewCell")
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        castCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: ConstantsInformation.leftDistanceToCell,
            bottom: 0,
            right: ConstantsInformation.rightDistanceToCell)
        
        castCollectionView.showsVerticalScrollIndicator = false
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        self.addSubview(castCollectionView)
    }
    
    private func setDelegate() {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
    private func getCastsByID() {
        if idMovie != 0 {
            guard let idMovie = idMovie else { return }
            networkService.getCast(id: idMovie, from: .movie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let castsArray):
                    self.casts = castsArray
                    self.isLoaded = true
                    self.castCollectionView.reloadData()
                case .failure(let error):
                    self.delegate?.showError(error)
                }
            }
        } else {
            guard let idTVShow = idTVShow else { return }
            networkService.getCast(id: idTVShow, from: .tv) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let castsArray):
                    self.casts = castsArray
                    self.isLoaded = true
                    self.castCollectionView.reloadData()
                case .failure(let error):
                    self.delegate?.showError(error)
                }
            }
        }
    }
}


//MARK: - UICollectionViewDataSource
extension CellForCollectionInformationTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoaded {
            return casts?.cast.count ?? 0
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoaded {
            let cell = collectionView.dequeueReusableCell(CastCollectionViewCell.self, for: indexPath)
            guard let casts = casts else { return UICollectionViewCell() }
            cell.configure(model: casts, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(ShimmerCollectionViewCell.self, for: indexPath)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension CellForCollectionInformationTableViewCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CellForCollectionInformationTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ConstantsInformation.galleryItemWidth, height: frame.height)
    }
}

//MARK: - setConstraint
extension CellForCollectionInformationTableViewCell {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            castCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            castCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            castCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            castCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            castCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}


