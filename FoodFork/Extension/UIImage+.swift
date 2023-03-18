//
//  UIImage+.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/15.
//

import Foundation
import UIKit

extension UIImage {
    
    func ratioCropImage(_ ratio: CGFloat, _ width: CGFloat) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        
        let cropImage = cgImage.cropping(to: CGRect(origin: .zero, size: CGSize(width: width, height: width/ratio)))
        print(width)
        print(cgImage.height)
        return UIImage(cgImage: cropImage ?? cgImage,
                       scale: self.imageRendererFormat.scale,
                       orientation: self.imageOrientation)
    }
    func resize(to size: CGSize) -> UIImage {
            return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    func resize(newWidth: CGFloat) -> UIImage {
            let scale = newWidth / self.size.width
            let newHeight = self.size.height * scale

            let size = CGSize(width: newWidth, height: newHeight)
            let render = UIGraphicsImageRenderer(size: size)
            let renderImage = render.image { context in
                self.draw(in: CGRect(origin: .zero, size: size))
            }
            
            print("화면 배율: \(UIScreen.main.scale)")// 배수
            print("origin: \(self), resize: \(renderImage)")
//            printDataSize(renderImage)
            return renderImage
        }
    
    // 원하는 해상도에 맞게 조절
    func downSample1(scale: CGFloat) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.pngData()! as CFData
        let imageSource = CGImageSourceCreateWithData(data, nil)!
        let maxPixel = max(self.size.width, self.size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary

        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!

        let newImage = UIImage(cgImage: downSampledImage)
//        printDataSize(newImage)
        return newImage
    }


    // 이미지뷰 크기에 맞게 조절
    func downSample2(size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.pngData()! as CFData
        let imageSource = CGImageSourceCreateWithData(data, imageSourceOption)!

        let maxPixel = max(size.width, size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary

        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!

        let newImage = UIImage(cgImage: downSampledImage)
//        printDataSize(newImage)
        return newImage
    }
}
