//
//  BottomSheet.swift
//  PomodoroUIKit
//
//  Created by Dinmukhambet Turysbay on 08.05.2023.
//

import UIKit

class BottomSheet: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {
    let photos = ["wave-bcg", "space-bcg", "raining-bcg", "gradient-bcg", "forest-bcg","cloud-bcg"]
    var selectedPhoto: String?
    
    lazy var layout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        let backGroundView  = UIView()
        backGroundView.backgroundColor = .white
        backGroundView.layer.cornerRadius = 12
        self.view.addSubview(backGroundView)
        backGroundView.anchor(left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 400)

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height - 300, width: view.frame.width, height: 300), collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self

//        view.addSubview(collectionView)
        backGroundView.addSubview(collectionView)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoImageView.image = UIImage(named: photos[indexPath.row])
        return cell
    }

    // MARK: - UICollectionViewDelegate methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto = photos[indexPath.row]
        print("Selected photo: \(selectedPhoto!)")
    }

    // MARK: - UICollectionViewDelegateFlowLayout methods

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

}
