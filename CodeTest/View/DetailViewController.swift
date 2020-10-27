//
//  DetailViewController.swift
//  CodeTest
//
//  Created by Thomas Romay on 27/10/2020.
//  Copyright © 2020 Thomas Romay. All rights reserved.
//

import Kingfisher
import UIKit

class DetailViewController: UIViewController, StoryboardBased {
    static var storyboardName: String {
        return "Main"
    }

    // MARK: - IBOutlet:
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var seasonAppreanceLabel: UILabel!

    // MARK: - ViewModel:
    var viewModel: SampleDetailViewModel? {
        didSet {}
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
        self.setup()
        self.viewModel?.onViewDidLoad()
    }
    func setup(){
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 12
    }
    func bindUI() {
        self.viewModel?.detailList.addObserver(self) {
            self.title = $0?.name
            self.nickNameLabel.text = $0?.nickname

            if let occuptaionStrings = $0?.occupation {
                self.occupationLabel.attributedText = self.bulletPointList(strings: occuptaionStrings.map { String($0) })
            }
            if let appearance = $0?.appearance {
                let item = appearance.map { String($0) }.map { "Season:" + $0 }
                self.seasonAppreanceLabel.attributedText = self.bulletPointList(strings: item)
            }
            if let status = $0?.status.rawValue {
                self.statusLabel.attributedText = self.bulletPointList(strings: [status])
            }
            self.imageView.kf.setImage(with: URL(string: $0?.img ?? String()))
        }
    }

    func bulletPointList(strings: [String]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 15
        paragraphStyle.minimumLineHeight = 15
        paragraphStyle.maximumLineHeight = 15
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]

        let stringAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let string = strings.map { "•\t\($0)" }.joined(separator: "\n")

        return NSAttributedString(string: string,
                                  attributes: stringAttributes)
    }
}
