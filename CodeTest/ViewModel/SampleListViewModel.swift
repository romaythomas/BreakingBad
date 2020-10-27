//
//  SampleListViewModel.swift
//  CodeTest
//
//  Created by Thomas Romay on 26/10/2020.
//  Copyright © 2020 Thomas Romay. All rights reserved.
//

import Foundation
class SampleListViewModel {
    // MARK: - Parametres
    var sampleAPIHelper = SampleAPIHelper()
    var childViewModel: DynamicValue<SampleDetailViewModel?> = DynamicValue(nil)
    var charcterList: DynamicValue<[SampleCollectionViewCell.ViewModel]> = DynamicValue([])
    var list: SampleModel = [] {
        didSet {
            self.buildList(payload: self.list)
        }
    }
    
    var searchString = DynamicValue(String())
    // MARK: - ViewModel Action Methods:
    
    func onViewLoaded() {
        self.fetchData()
    }
    
    func onSearchStringUpdated(to value: String) {
        self.searchString.value = value
        if !self.searchString.value.isEmpty {
            self.buildList(payload: self.list.filter { $0.name.lowercased().contains(self.searchString.value.lowercased()) })
        } else {
            self.buildList(payload: list)
        }
    }
    
    func onItemSelected(charId: Int) {
        let selectedItem = self.list.filter { $0.charID == charId }
        self.childViewModel.value = SampleDetailViewModel(model: selectedItem.first)
    }
    
    // MARK: - Private Funcs:
    func fetchData() {
        self.sampleAPIHelper.getApiFeed { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let payload):
                self.list = payload ?? []
                
            case .failure(let erro):
                print(erro)
            }
        }
    }
    
    private func buildList(payload: SampleModel) {
        self.charcterList.value = payload.map {
            SampleCollectionViewCell.ViewModel()
                .setId($0.charID)
                .setBackgroundImage(URL(string: $0.img))
                .setLabelDescription($0.name)
        }
    }
}
