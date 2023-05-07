//
//  SettingsViewController.swift
//  PomodoroUIKit
//
//  Created by Dinmukhambet Turysbay on 07.05.2023.
//

import UIKit

class SettingsViewController:  UIViewController
, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {
    let photos = ["wave-bcg", "space-bcg", "raining-bcg", "gradient-bcg", "forest-bcg","cloud-bcg"]
    var selectedPhoto: String?


    let playButton: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        playButton.layer.cornerRadius = min(playButton.frame.width, playButton.frame.height) / 2
        playButton.backgroundColor = .gray
        playButton.tintColor = UIColor.white
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        return playButton
    }()
    
    let layout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    let vc = BottomSheet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [playButton].forEach {
            view.addSubview($0)
        }

        playButton.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingBottom: 300)
        playButton.addTarget(self, action: #selector(showBottomSheetButtonTapped), for: .touchUpInside)

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height - 300, width: view.frame.width, height: 300), collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.backgroundColor = UIColor.black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        super.view.addSubview(collectionView)
//        view.addSubview(collectionView)
    }
    
    @objc func smth(){
        print("hi")
    }

    @objc func showBottomSheetButtonTapped() {
        print("here")        
        vc.modalPresentationStyle = .formSheet
        let nav = UINavigationController(rootViewController: vc)
   
//        nav.isModalInPresentation = true
        if let sheet = nav.sheetPresentationController {
               sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
           }
        self.present(nav, animated: true, completion: nil)

    }

//     MARK: - UICollectionViewDataSource methods

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

class PhotoCell: UICollectionViewCell {

    let photoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        photoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        photoImageView.anchor(paddingBottom: 200)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
