//
//  Request-GET&POST.swift
//  Model_API_Reuse
//
//  Created by 柏呈 on 2019/1/22.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation

struct Request {
    static func getRequest(callURL:String, header:[String:String], callBack: @escaping ([String:Any]) -> Void){
        let url = URL(string: callURL)
        var urlRequest = URLRequest(url: url!)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            guard let data = data, error == nil  else {
                print(error?.localizedDescription)
                return
            }
            let json_Response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let jsonResponse = json_Response as? [String:Any] {
                callBack(jsonResponse)
            }
        }
    task.resume()
}
    static func postRequest(callURL:String, header:[String:String], body:[String:String
        ] ,callBack: @escaping ([String:Any]) -> Void){
        
        let url = URL(string: callURL)
        var urlRequest = URLRequest(url: url!)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        let bodys = try? JSONEncoder().encode(body)
        urlRequest.httpBody = bodys
        urlRequest.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            guard let data = data, error == nil  else {
                print(error?.localizedDescription)
                return
            }
            let json_Response = try? JSONSerialization.jsonObject(with: data, options: [])
            // as?後面可以轉型成為自定義的Model   but!自定義的Model要完全符合
            if let jsonResponse = json_Response as? [String:Any] {
                callBack(jsonResponse)
            }
        }
        task.resume()
    }
}

