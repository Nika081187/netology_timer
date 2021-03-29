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
    var timer: Timer = Timer()
    var timerPeriod = 10
    
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

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(timerPeriod)"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.backgroundColor = .white
        label.toAutoLayout()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timerLabel)
        view.addSubview(contentView)
        contentView.addSubview(photoCollectionView)
        setupLayout()
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if(timerPeriod > 0) {
            timerLabel.text = "\(timerPeriod)"
            print("timer \(timerPeriod)")
            timerPeriod -= 1
        } else {
            timerPeriod = 10
            photoCollectionView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        timer.invalidate()
        print("view will disappear")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: baseOffset),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: baseOffset),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 50),

            contentView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: baseOffset),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            photoCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
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
