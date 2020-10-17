//
//  TitleLabelSelectionView.swift
//  DropDown
//
//  Created by hoangnc on 18/10/20.
//

import UIKit

protocol TitleLabelSelectionViewDelegate: class {
    func didSelect(_ titleLabelSelectionView: TitleLabelSelectionView, text: String)
}

class TitleLabelSelectionView: UIView {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: TitleLabelSelectionViewDelegate?

    var title: String? {
        get {
            return self.titleLabel.text
        }
        set(value) {
            self.titleLabel.text = value
        }
    }

    var coverColor: UIColor? {
        get {
            return self.backGroundView.backgroundColor
        }
        set(value) {
            self.backGroundView.backgroundColor = value
        }
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// :nodoc:
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        _ = fromNib(nibName: String(describing: TitleLabelSelectionView.self), isInherited: true)
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textColor = ColorTheme.deepBlue
        lineView.backgroundColor = ColorTheme.light

        self.coverColor = ColorTheme.lightGrey
    }

    @IBAction func eventClickButton(_ sender: Any) {
        guard let text = self.title else { return }
        self.delegate?.didSelect(self, text: text)
    }
}
