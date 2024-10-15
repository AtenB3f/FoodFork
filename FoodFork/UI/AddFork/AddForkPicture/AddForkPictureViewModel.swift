//
//  AddForkPictureViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import AVFoundation
import PhotosUI
import RxSwift
import RxCocoa

class AddForkPictureViewModel {
    
    var seletImages:[UIImage] = []
    
    let disposeBag = DisposeBag()
    
    
    func cameraAuth(viewController: UIViewController, imagePicker: PHPickerViewController) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("권한 허용")
                self.openCamera(viewController: viewController, imagePicker: imagePicker)
            } else {
                print("권한 거부")
                self.showAlertAuth(viewController: viewController, imagePicker: imagePicker, "카메라")
            }
        }
    }
        
    func albumAuth(viewController: UIViewController, imagePicker: PHPickerViewController) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            print("거부")
            self.showAlertAuth(viewController: viewController, imagePicker: imagePicker, "앨범")
        case .authorized:
            print("허용")
            self.openPhotoLibrary(viewController: viewController, imagePicker: imagePicker)
        case .notDetermined, .restricted:
            print("아직 결정하지 않은 상태")
            PHPhotoLibrary.requestAuthorization { state in
                if state == .authorized {
                    self.openPhotoLibrary(viewController: viewController, imagePicker: imagePicker)
                } else {
                    viewController.dismiss(animated: true, completion: nil)
                }
            }
        default:
            break
        }
    }
        
    func showAlertAuth(viewController: UIViewController, imagePicker: PHPickerViewController, _ type: String) {
        if let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
            let alertVC = UIAlertController(
                title: "설정",
                message: "\(appName)이(가) \(type) 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
                preferredStyle: .alert
            )
            let cancelAction = UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(confirmAction)
            viewController.present(alertVC, animated: true, completion: nil)
        }
    }
    
     func openPhotoLibrary(viewController: UIViewController, imagePicker: PHPickerViewController) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            DispatchQueue.main.async {
                imagePicker.modalPresentationStyle = .currentContext
            }
            viewController.present(imagePicker, animated: true, completion: nil)
        } else {
            print("앨범에 접근할 수 없습니다.")
        }
    }

    func openCamera(viewController: UIViewController, imagePicker: PHPickerViewController) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.modalPresentationStyle = .currentContext
            viewController.present(imagePicker, animated: true, completion: nil)
        } else {
            print("카메라에 접근할 수 없습니다.")
        }
    }

    
}
