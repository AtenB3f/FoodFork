//
//  APIServer.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/18/24.
//

import UIKit

public struct RequestBuilder {
    private let url: URL?
    private let method: NetworkMethod
    private let body: Data?
    private let headers: [String: String]

    init(url: URL?,
         method: NetworkMethod,
         body: Data? = nil,
         headers: [String: String] = ["Content-Type": "application/json"]) {

        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
    }

    func create() -> URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue.uppercased()
        
        if let body = body {
            request.httpBody = body
        }
        
        request.allHTTPHeaderFields = headers
        
        print(request)
        print(request.httpMethod ?? "")
        print(request.httpBody ?? "")
        print(request.allHTTPHeaderFields ?? "")
        
        return request
    }
}

public class APIServer {
    public init() {
        
    }
    let session = URLSession.shared
    
    public func request<T:Codable>(_ type: APIType, _ resultType: T.Type, callback: @escaping (T?)->Void) {
        let url = getURL(type)
        let method = getMethod(type)
        let body = getBody(type)
        let header = getHeader(type)
        
        if let request = RequestBuilder(url: url, method: method, body: body, headers: header).create() {
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Request Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Request Data is nil")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("status code : \(response.statusCode)")
                } else {
                    print("response is nil")
                }
                
                let dataToString = String(decoding: data, as: UTF8.self)
                print("Result Data: \(dataToString)")
                
                let decoder = JSONDecoder()
                if let result = try? decoder.decode(resultType, from: data) {
                    callback(result)
                } else {
                    print("Error Decode Data")
                }
            }
            
            task.resume()
        }
    }
}

extension APIServer {
    func getURL(_ type: APIType)->URL{
        switch type {
        case .kakaoSearchKeyword(_, let keyword, let page, let size, let sort):
            return URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json?size=\(size)&sort=\(sort)&page=\(page)&query=\(keyword)")!
        }
    }
    
    func getMethod(_ type: APIType)->NetworkMethod{
        switch type {
        default:
            return .get
        }
    }
    
    func getBody(_ type: APIType)->Data?{
        return nil
    }
    
    func getHeader(_ type: APIType)->[String:String]{
        var header:[String:String] = ["Content-Type": "application/json"]
        
        switch type {
        case .kakaoSearchKeyword(let token, _, _, _, _):
            header["Authorization"] = "KakaoAK \(token)"
        }
        
        return header
    }
}
