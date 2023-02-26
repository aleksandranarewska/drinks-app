//
//  HttpRequestHelper.swift
//  Drinks
//
//  Created by Admin on 25/02/2023.
//

import Foundation
import UIKit
class HttpRequestHelper{
    static let shared = HttpRequestHelper()
    func getData<T : Codable>(type : T?, url: URL ,completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
            else {
                completion(nil)
                return }
            let jsonDecoder = JSONDecoder()
            do{
                let decodedData = try jsonDecoder.decode(T.self, from: data)
                completion(decodedData)
            }catch let error{
                completion(nil)
                print(error.localizedDescription)
            }
        }.resume()
        
        
    }
    func downloadImage(from url: URL,completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    func downloadImage(from link: String,complete: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: link) else {
            complete(nil)
            return
        }
        downloadImage(from: url){
            value in
            complete(value)
        }
    }
}
