//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import UIKit
import ReactiveSwift
import Model

class NewsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var articlesActivityIndicator: UIActivityIndicatorView!
    
    var articleViewModel = ArticleViewModel()
    var categoriesViewModel = CategoryViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupCollectionView()
        self.prepareCategoriesModel()
    }
    
    fileprivate func prepareCategoriesModel() {
        self.categoriesViewModel.fetchSources()
        self.categoriesViewModel.disposable += self.categoriesViewModel.cellModels.signal.observeValues({ _ in
            self.prepareArticlesModel(from: self.categoriesViewModel.sources.first!)
            self.collectionView.reloadData()
        })
    }
    
    fileprivate func prepareArticlesModel(from source: Source) {
        self.articleViewModel.fetchArticles(from: source)
        self.articleViewModel.disposable += self.articleViewModel.cellModles.signal.observeValues({ _ in
            self.tableView.reloadData()
        })
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.cellModles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableCell.identifier, for: indexPath) as! ArticleTableCell
        cell.article = articleViewModel.cellModles.value[indexPath.row]
        return cell
    }
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesViewModel.cellModels.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        cell.category = categoriesViewModel.cellModels.value[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(
            at: indexPath,
            at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        self.prepareArticlesModel(from: categoriesViewModel.sources[indexPath.item])
    }
}
