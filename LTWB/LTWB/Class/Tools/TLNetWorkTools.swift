//
//  TLNetWorkTools.swift
//  LTWB
//
//  Created by corepress on 2018/5/23.
//  Copyright © 2018年 corepress. All rights reserved.
//

import AFNetworking

enum TLHTTPMethod : String{
    case GET = "GET"
    case POST = "POST"
}

class TLNetWorkTools: AFHTTPSessionManager {
    // 静态区／常量／闭包 /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared : TLNetWorkTools = {
        // 实例化对象
        let instance = TLNetWorkTools()
        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        // 返回对象
        return instance }()

}

extension TLNetWorkTools {

    func request(requestType :TLHTTPMethod, url : String, parameters : [String : Any],  finished : @escaping([String : Any]?, Error?) -> ()) {
        
         // 成功闭包
        let successBlock = { (task: URLSessionDataTask, result : Any?) in
            finished(result as?[String : Any],nil)
        }
          // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?,  error: Error) in
            finished(nil,error)
        }

        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }

        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
}

//MARK:请求access token
extension TLNetWorkTools {
    
    func requestAccesstoken(code : String,finished : @escaping ([String : Any]?,Error?) -> ()) {
        
         let url = "https://api.weibo.com/oauth2/access_token"
         let parameters = ["client_id":AppKey,"client_secret":AppSecret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri]
        
         request(requestType: .POST, url: url, parameters: parameters) { (result, error) in
            if error == nil {
                finished(result,nil)
            }else {
                finished(nil,error)
            }
        }
    }
    
    
}
