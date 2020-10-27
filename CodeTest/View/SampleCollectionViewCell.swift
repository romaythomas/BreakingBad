//
//  SampleCollectionViewCell.swift
//  CodeTest
//
//  Created by Thomas Romay on 26/10/2020.
//  Copyright © 2020 Thomas Romay. All rights reserved.
//

import Kingfisher
import UIKit

class SampleCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    struct ViewModel: Hashable {
        var id: Int = Int()
        var description: String = String()

        var backgroundImage: URL?

        func setId(_ id: Int) -> ViewModel {
            var viewModel = self
            viewModel.id = id
            return viewModel
        }

        func setLabelDescription(_ description: String) -> ViewModel {
            var viewModel = self
            viewModel.description = description
            return viewModel
        }

        func setBackgroundImage(_ backgroundImage: URL?) -> ViewModel {
            var viewModel = self
            viewModel.backgroundImage = backgroundImage
            return viewModel
        }
    }

    // MARK: - IBOutlets:
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!

    // MARK: - ViewModel:
    var viewModel: ViewModel! {
        didSet {
            self.configure()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        self.imageView.image = nil
    }

    func configure() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 12

        self.descriptionView.layer.masksToBounds = true
        self.descriptionView.layer.cornerRadius = 12

        self.descriptionLabel.text = self.viewModel.description
        self.imageView.kf.indicatorType = .activity

        self.imageView.kf.setImage(with: self.viewModel.backgroundImage)
    }
}
