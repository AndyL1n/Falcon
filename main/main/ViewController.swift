//
//  ViewController.swift
//  main
//
//  Created by Andy on 2022/3/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: NewsViewModel = {
        return NewsViewModel()
    }()

    private var dataSourceKey: [String] {
        return viewModel.dataSorce.keys.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    private func setupUI() {
        viewModel.fetchNewsList { [weak self] in
            self?.collectionView.reloadData()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NewsItemCell", bundle: .main), forCellWithReuseIdentifier: NewsItemCell.id)
        collectionView.register(UINib(nibName: "NewsHeader", bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsHeader.id)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceKey.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = dataSourceKey[section]
        
        return viewModel.dataSorce[key]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let key = dataSourceKey[indexPath.section]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsItemCell.id, for: indexPath) as? NewsItemCell,
           let item = viewModel.dataSorce[key]?[indexPath.item] {
            cell.config(with: item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let key = dataSourceKey[indexPath.section]
        if kind == UICollectionView.elementKindSectionHeader,
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NewsHeader.id, for: indexPath) as? NewsHeader {
            header.config(with: key)
            return header
        }
        return UICollectionReusableView()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: NewsItemCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: NewsHeader.height)
    }
}
