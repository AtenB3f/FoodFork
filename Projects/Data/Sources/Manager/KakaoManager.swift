//
//  KakaoManager.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import RxSwift
import UIKit

public class KakaoManager {
    public static let appKey = "d8cae7af7226ef488a329b0c06dbf059"
    public static let authKey = "7a6d94e0e9b16acc58cf20f4b9537505"
}

func downloadJson(_ url: String) -> Observable<String?> {
    Observable.create { emitter in
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
            guard err == nil else {
                emitter.onError(err!)
                return
            }

            if let dat = data, let json = String(data: dat, encoding: .utf8) {
                emitter.onNext(json)
            }

            emitter.onCompleted()
        }

        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }
}
