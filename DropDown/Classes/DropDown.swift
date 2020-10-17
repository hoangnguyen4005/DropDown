//
//  DropDown.swift
//  DropDown
//
//  Created by hoangnc on 18/10/20.
//

import UIKit

public protocol DropDownDataSource: class {
    func numberOfSelections(dropDown: DropDown) -> [String]
}

public protocol DropDownDelegate: class {
    func didExpand(dropDown: DropDown)
    func didSelectOption(dropDown: DropDown)
}

public class DropDown: UIView {
    @IBOutlet weak var textInputView: InputTextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backGroundView: UIView!
    public weak var dataSource: DropDownDataSource?
    public weak var delegate: DropDownDelegate?

    public var isExpand: Bool = false {
        didSet {
            if isExpand {
                guard let dataSource = self.dataSource else { return }
                self.stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
                for item in dataSource.numberOfSelections(dropDown: self) {
                    let selectionView = TitleLabelSelectionView()
                    selectionView.title = item
                    selectionView.delegate = self
                    self.stackView.addArrangedSubview(selectionView)
                }
                self.textInputView.rightIcon = iconDown
            } else {
                self.stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
                self.textInputView.rightIcon = iconUp
            }
        }
    }
    
    public var iconUp: UIImage?
    public var iconDown: UIImage?

    public var placeHolder: String? {
        get {
            return self.textInputView.placeHolder
        }
        set(value) {
            self.textInputView.placeHolder = value
        }
    }

    public var text: String? {
        get {
            return self.textInputView.text
        }
        set(value) {
            self.textInputView.text = value
        }
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
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
        _ = fromNib(nibName: String(describing: DropDown.self), isInherited: true)
        self.textInputView.verticalPadingTextFiledAndIcon = 10.0 //Per design
        self.textInputView.style = .leading
        self.isExpand = false
        self.textInputView.disableEditInputField = true
        self.textInputView.rightIconTapAction = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.isExpand = !weakSelf.isExpand
            weakSelf.delegate?.didExpand(dropDown: weakSelf)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent))
        textInputView.isUserInteractionEnabled = true
        textInputView.addGestureRecognizer(tap)
    }

    @objc func tapEvent() {
        self.isExpand = !self.isExpand
        self.delegate?.didExpand(dropDown: self)
    }

    func animationExpandText() {
        self.textInputView.animationExpandText()
    }

    public func setDropDownColor(color: UIColor) {
        self.backGroundView.backgroundColor = color
        self.textInputView.backgroundColor = ColorTheme.white
    }
}

extension DropDown: TitleLabelSelectionViewDelegate {
    func didSelect(_ titleLabelSelectionView: TitleLabelSelectionView, text: String) {
        self.textInputView.text = text
        self.textInputView.animationExpandText()
        self.isExpand = !self.isExpand
        self.delegate?.didSelectOption(dropDown: self)
    }
}
