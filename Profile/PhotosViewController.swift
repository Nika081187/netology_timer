//
//  PhotosViewController.swift
//  Navigation
//
//  Created by v.milchakova on 13.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let baseOffset: CGFloat = 8
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.toAutoLayout()
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.addSubview(photoCollectionView)
        setupLayout()
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        
        let userInfo = "userInfo"
        
        let myTimer = Timer(timeInterval: 30, target: self, selector: #selector(timerDidFire), userInfo: userInfo, repeats: true)
        
        RunLoop.current.add(myTimer, forMode: RunLoop.Mode.common)
    }
    
    @objc func timerDidFire() {
        print("Timer!")
        showReloadAlert()
    }
    
    func showReloadAlert() {
        let alertController = UIAlertController(title: "Время отдохнуть!", message: "Вы очень долго находитесь на странице, нужно дать отдых глазам! :)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            print("Ок")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            photoCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoStorage().photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell

        let image = PhotoStorage().photos[indexPath.item]
        cell.configure(image: image)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width  - 4 * baseOffset) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return baseOffset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return baseOffset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: baseOffset, left: baseOffset, bottom: baseOffset, right: baseOffset)
    }
}
