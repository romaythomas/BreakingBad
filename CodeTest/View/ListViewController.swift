//
//  ListViewController.swift
//  CodeTest
//
//  Created by Thomas Romay on 26/10/2020.
//  Copyright © 2020 Thomas Romay. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, StoryboardBased {
    static var storyboardName: String {
        return "ViewController"
    }

    // MARK: - IBOutlet:
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - parameter:
    let searchViewcontroller = UISearchController(searchResultsController: nil)

    var charcterList: [SampleCollectionViewCell.ViewModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - ViewModel:
    var viewModel = SampleListViewModel()
    var childViewModel = SampleDetailViewModel(model: nil) {
        didSet {
            let viewController = DetailViewController.instantiate()
            viewController.viewModel = childViewModel
            self.show(viewController, sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bindUI()
        self.viewModel.onViewLoaded()
    }

    private func bindUI() {
        self.viewModel.charcterList.addObserver(self) {
            self.charcterList = $0
        }
        self.viewModel.childViewModel.addObserver(self) {
            guard let childViewModel = $0 else { return }
            self.childViewModel = childViewModel
        }
        self.viewModel.searchString.addAndNotify(observer: self) {
            self.searchViewcontroller.searchBar.text = $0
        }
    }

    private func setupView() {
        self.setupNavBar()
        self.setupStatsCollectionView()
    }

    private func setupStatsCollectionView() {
        self.collectionView.register(SampleCollectionViewCell.nib, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    private func setupNavBar() {
        self.searchViewcontroller.obscuresBackgroundDuringPresentation = false
        self.searchViewcontroller.searchBar.placeholder = "Search"
        self.searchViewcontroller.searchBar.delegate = self

        self.navigationItem.searchController = searchViewcontroller
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - SearchBar Delegate:

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let value = searchBar.text else { return }
        self.viewModel.onSearchStringUpdated(to: value)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.onSearchStringUpdated(to: "")
    }
}

extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.charcterList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as! SampleCollectionViewCell
        cell.viewModel = self.charcterList[indexPath.row]
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.charcterList[indexPath.row].id
        self.viewModel.onItemSelected(charId: id)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        return CGSize(width: screenBounds.width * 0.40, height: screenBounds.width * 0.6)
    }
}
