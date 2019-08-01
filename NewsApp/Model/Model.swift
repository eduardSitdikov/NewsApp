//
//  Model.swift
//  NewsApp
//
//  Created by Eduard on 22/07/2019.
//  Copyright © 2019 Eduard. All rights reserved.
//

import Foundation

var articles: [Article] {
    let data = try? Data(contentsOf: urlToDate)
    if data == nil{
        return []
    }
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil{
        return []
    }
    let rootDictionary = rootDictionaryAny as? Dictionary<String,Any>
    if rootDictionary == nil{
        return []
    }
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String,Any>]{
        var returnArray: [Article] = []
        for dict in array{
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        return returnArray
    }
    return []
}

var urlToDate: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}
//
func loadNews(completionHandler:(()->Void)?){
    let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2019-07-01&sortBy=publishedAt&apiKey=4548d10554124558acae722c9c97f096")
    
    let session = URLSession(configuration: .default)
    let dounloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
        if urlFile != nil{
            try? FileManager.default.copyItem(at: urlFile!, to: urlToDate)
            completionHandler?()
            
        }
    }
    
    dounloadTask.resume()
}
