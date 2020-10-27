//
//  SampleDetailViewModel.swift
//  CodeTest
//
//  Created by Thomas Romay on 27/10/2020.
//  Copyright © 2020 Thomas Romay. All rights reserved.
//

import Foundation
class SampleDetailViewModel {
    let detailList: DynamicValue<SampleModelElement?> = DynamicValue(nil)
    let model: SampleModelElement?
    init(model: SampleModelElement?) {
        self.model = model
    }

    func onViewDidLoad() {
        self.detailList.value = self.model
    }
}
