//
//  Request-GET&POST.swift
//  Model_API_Reuse
//
//  Created by 柏呈 on 2019/1/22.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation

struct Request {
    static func getRequest(withURL callURL: String, withHeader headers: [String:String], _ callBack: @escaping ([String:Any]) -> Void){
        let url = URL(string: callURL)
        var urlRequest = URLRequest(url: url!)
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
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
    static func postRequest(withURL callURL: String, withHeader headers: [String:String],withBody body: [String:String
        ] ,_ callBack: @escaping ([String:Any]) -> Void){
        
        let url = URL(string: callURL)
        var urlRequest = URLRequest(url: url!)
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        let bodys = try? JSONEncoder().encode(body)
        urlRequest.httpBody = bodys
        urlRequest.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                guard let httpResponse = response as?  HTTPURLResponse else{
                    return
                }
                //   if httpResponse.statusCode ==
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                        // as?後面可以轉型成為自定義的Model   but!自定義的Model要完全符合
                        if let jsonResponse = jsonResponse as? [String:Any] {
                            callBack(jsonResponse)
                        }
                    }
                }
                
            }
            
        }
        task.resume()
    }
}
// TO DO List
//  * 把重複的code拉出來建一個func在需要的地方call就好，多做抽象化，別讓重複的code到處貼
//  * 有get和post後，可以做put方法
//  * 使用codable方便解析

// 建議
// * 先掌握每個語言都有的共通方法，再去學swift特有的
// * 先掌握 String, Protocol, Delegate, ARC, Class, Struct, Enum, Inheritance, Reference Type, Value Type, Closure, Initializer, Extension, Access Control,  OOP, Optional

