//
//  ViewController.swift
//  SaveState
//
//  Created by LanceMacBookPro on 7/24/21.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
    
    
    // MARK: - UIElements
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.register(TVShowCell.self, forCellWithReuseIdentifier: cellId)
        
        return cv
    }()
    
    fileprivate lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Propertis
    fileprivate let cellId = "cellId"
    fileprivate var datasource = [TVShowModel]()
    
    fileprivate var logoutBarButtonItem: UIBarButtonItem?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationAppearance()
        
        addTVShowsToDatasource()
        
        configureAnchors()
    }
    
    // MARK: - Target Actions
    @objc fileprivate func logoutButtonPressed() {
        
        UserDefaults.standard.set(false, forKey: "loggedIn")
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation Appearance
    fileprivate func setNavigationAppearance() {
        
        navigationItem.title = "TV Shows"
        
        navigationItem.hidesBackButton = true
        
        logoutBarButtonItem = UIBarButtonItem(customView: logoutButton)
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    // MARK: - Helper Functions
    fileprivate func addTVShowsToDatasource() {
        
        let tvShows = TVShowModel.createTVShowModels()
        datasource.append(contentsOf: tvShows)
        
        collectionView.reloadData()
    }
    
    fileprivate func generateHapticFeedback() {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    // MARK: - Anchors
    fileprivate func configureAnchors() {
        
        view.addSubview(collectionView)
        
        // collectionView
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - UICollectionViewDatasource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TVShowCell
        
        cell.delegate = self
        cell.tvShowModel = datasource[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        
        return CGSize(width: width, height: 100)
    }
}

// MARK: - TVShowCellDelegate
extension ViewController: TVShowCellDelegate {
    
    func likeButtonTapped(tvShowModel: TVShowModel?) {
        
        guard let tvShowModel = tvShowModel,
              let postId = tvShowModel.postId,
              let liked = tvShowModel.liked
        else { return }
        
        turnLikedButtonRedOrLightGray(for: postId, liked: liked, tvShowModel: tvShowModel)
    }
}

// MARK:- Change Like Button Color
extension ViewController {
    
    fileprivate func turnLikedButtonRedOrLightGray(for postId: String, liked: Bool, tvShowModel: TVShowModel) {
        
        guard let indexOfItem = datasource.firstIndex(where: { $0.postId ?? "" == postId }) else { return }
        
        let indexPath = IndexPath(item: indexOfItem, section: 0)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TVShowCell else { return }
        
        generateHapticFeedback()
        
        if liked {
            
            KeychainSwift().delete(postId)
            
            tvShowModel.liked = false
            
            cell.turnLikeButtonLightGray()
            
        } else {
            
            KeychainSwift().set(true, forKey: postId)
            
            tvShowModel.liked = true
            
            cell.turnLikeButtonRed()
        }
    }
}
