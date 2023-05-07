//
//  WebService.swift
//  GoodNews
//
//  Created by Luan.Lima on 04/05/23.
//

import Foundation

enum Error1: Error, LocalizedError {
    case falhaAoProcessarRequisicao(Error)
    case falhaAoObterResposta
    case dadosInvalidos
}

class WebService {
    
    var url = "https:newsapi.org/v2/top-headlines?country=us&apiKey=039fcad03a844959ae7d64f1f2918828"
   
    private var session = URLSession.shared
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    private var dataTask: URLSessionDataTask?
    
    func getArticles(completionHandler: @escaping (ArticlesList) -> Void,
                    failureHandler: @escaping (Error1) -> Void) {
        dataTask?.cancel()
        
        let url = URL(string: url)!
        
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async
                {
                    failureHandler(.falhaAoProcessarRequisicao(error))
                }
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                DispatchQueue.main.async {
                    failureHandler(.falhaAoObterResposta)
                }
                return
            }
                
            do {
                guard let self = self else { return }
                
                let currencies = try self.decoder.decode(ArticlesList.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(currencies)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                   print(error)
                    failureHandler(.dadosInvalidos)
                }
            }
        }
        
        dataTask?.resume()
    }
}





































//enum NetWorkingError: Error, LocalizedError {
//    case failedToFetchData(Error)
//    case dataNotFound
//    case invalidData
//
//
//}
//
//
//class WebService {
//
//    var url = "https:newsapi.org/v2/top-headlines?country=us&apiKey=039fcad03a844959ae7d64f1f2918828"
//    private var session = URLSession.shared
//    private var decoder = JSONDecoder.init()
//
//    func getArticles(completionHandler: @escaping ([ArticleList]?) -> Void,
//                     failureHandler: @escaping (NetWorkingError) -> Void) {
//
//
//
//        if let url = URL(string: url) {
//
//            let task = session.dataTask(with: url) { data, response, error in
//
//                if let error = error {
//                    DispatchQueue.main.async {
//                        failureHandler(.failedToFetchData(error))
//                    }
//                    return
//                }
//
//                guard let data = data,
//                      let response = response as? HTTPURLResponse,
//                      response.statusCode == 200 else {
//                    DispatchQueue.main.async {
//                        failureHandler(.dataNotFound)
//                    }
//                    return
//                }
//
//                do {
//
//                    let articlesApi = try self.decoder.decode([ArticleList].self, from: data)
//
//                    DispatchQueue.main.async {
//                        completionHandler(articlesApi)
//                    }
//
//                } catch let error {
//                    DispatchQueue.main.async {
//                        print(error)
//                        failureHandler(.invalidData)
//                    }
//
//                }
//
//
//
//
//            }
//            task.resume()
//        }
//
//    }
//
//  }
