//
//  KakaoAPI.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import RxSwift
import UIKit

class APIServer {
    func request(url: URL) {
        let asdf: Bool = false

        print(asdf)
    }
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
