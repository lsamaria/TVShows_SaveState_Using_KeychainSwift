//
//  TVShowCell.swift
//  SaveState
//
//  Created by LanceMacBookPro on 7/24/21.
//

import UIKit
import KeychainSwift

protocol TVShowCellDelegate: class {
    
    
    func likeButtonTapped(tvShowModel: TVShowModel?)
}

class TVShowCell: UICollectionViewCell {
    
    // MARK: - UIElements
    fileprivate lazy var showNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    fileprivate lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heartIcon"), for: .normal)
        return button
    }()
    
    fileprivate lazy var invisibleLikeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        let titleColor = UIColor.clear // .purple
        button.setTitleColor(titleColor, for: .normal)
        
        let backgroundColor = UIColor.clear // .black
        button.backgroundColor = backgroundColor
        
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Properties
    weak var delegate: TVShowCellDelegate?
    
    public var tvShowModel: TVShowModel? {
        didSet {
            
            guard let tvShowModel = tvShowModel else { return }
            
            showNameLabel.text = tvShowModel.showName ?? "Show Name Missing"
            
            setLikeButtonColorAndLikeValue(for: tvShowModel)
            
            configureAnchors()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    // MARK: - Target Actions
    @objc fileprivate func likeButtonPressed() {
        
        delegate?.likeButtonTapped(tvShowModel: tvShowModel)
    }
    
    // MARK:- Helper Functions
    fileprivate func setLikeButtonColorAndLikeValue(for tvShowModel: TVShowModel) {
        
        guard let postId = tvShowModel.postId else { return }
        
        let liked = KeychainSwift().getBool(postId) ?? false
        
        if liked {
            
            turnLikeButtonRed()
            
            tvShowModel.liked = true
            
        } else {
            
            turnLikeButtonLightGray()
            
            tvShowModel.liked = false
        }
    }
    
    public func turnLikeButtonRed() {
        likeButton.tintColor = .red
    }
    
    public func turnLikeButtonLightGray() {
        likeButton.tintColor = .lightGray
    }
    
    // MARK: - Anchors
    fileprivate func configureAnchors() {
        
        contentView.addSubview(showNameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(separatorLine)
        contentView.addSubview(invisibleLikeButton)
        
        // showNameLabel
        showNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        showNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        showNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        // likeButton
        likeButton.topAnchor.constraint(equalTo: showNameLabel.bottomAnchor, constant: 10).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // invisibleLikeButton
        invisibleLikeButton.topAnchor.constraint(equalTo: showNameLabel.bottomAnchor).isActive = true
        invisibleLikeButton.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor).isActive = true
        invisibleLikeButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        invisibleLikeButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        // separatorLine
        separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
