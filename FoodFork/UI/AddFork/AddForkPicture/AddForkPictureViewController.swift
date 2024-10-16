//
//  AddForkPictureViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import AVFoundation
import PhotosUI

class AddForkPictureViewController: UIViewController, PHPickerViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAttribute()
    }

    func setLayout() {
        self.view.addSubview(pictureView)
        
        pictureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    func setAttribute() {
        self.view.backgroundColor = .white
        
        self.imagePicker.delegate = self
        
        pictureView.list.delegate = self
        pictureView.list.dataSource = self
        pictureView.list.register(AddForkPictureItemView.self, forCellWithReuseIdentifier: AddForkPictureItemView.id)
        pictureView.list.isPagingEnabled = true
        
        pictureView.button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)

    }

    var navigation: NavigationDelegate? {
        didSet {
            pictureView.navigation = navigation
        }
    }
    
    let imagePicker: PHPickerViewController = {
        let config: PHPickerConfiguration = {
            var picker = PHPickerConfiguration()
            picker.selectionLimit = 5
            picker.filter = .images
            
            return picker
        }()
        
        let picker = PHPickerViewController(configuration: config)
        
        return picker
    }()

    lazy var pictureView =  AddForkPictureView()
    
    var viewModel = AddForkPictureViewModel()
    var parentViewModel: AddForkViewModel?
    
    @objc func onClickButton() {
        if viewModel.seletImages.isEmpty {
            viewModel.albumAuth(viewController: self, imagePicker: imagePicker)
        } else {
            parentViewModel?.fork.pictures = viewModel.seletImages
            viewModel.saveAllImage(storeName: parentViewModel?.fork.storeName ?? UUID().uuidString)
            navigation?.pushNavigation(target: .addForkReview(parentViewModel: parentViewModel ?? AddForkViewModel()))
        }
    }
    
    // Delegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.imagePicker.dismiss(animated: true)
        let providers = results.map { $0.itemProvider }
        for provider in providers {
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let image = image as? UIImage, let self = self {
                        DispatchQueue.main.async {
                            self.viewModel.seletImages.append(image)
                            self.pictureView.button.setTitle("다음", for: .normal)
                            self.pictureView.list.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
}

extension AddForkPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.seletImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddForkPictureItemView.id , for: indexPath) as? AddForkPictureItemView else { return UICollectionViewCell() }
        cell.imageView.image = viewModel.seletImages[indexPath.item]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension AddForkPictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
}
