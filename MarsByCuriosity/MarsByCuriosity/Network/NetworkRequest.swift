//
//  NetworkRequest.swift
//  MarsByCuriosity
//
//

import Foundation

final class NetworkRequest: NSObject {
    private func handler<T: Codable>(data: Data?, error: Error?, completion: @escaping(Result<T, ErrorInfo>)->()) {
        
        guard let data = data else {
            completion(.failure(ErrorInfo(message: LS("INTERNAL.SERVER.ERROR"), code: nil, success: false)))
            return
        }
        
        if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(decodedResponse))
        } else if let errorResponse = try? JSONDecoder().decode(ErrorInfo.self, from: data) {
            completion(.failure(errorResponse))
        } else if let error = error {
            completion(.failure(ErrorInfo(message: error.localizedDescription, code: nil, success: false)))
        } else {
            completion(.failure(ErrorInfo(message: LS("FAILED.TO.LOAD.DATA.ERROR"), code: nil, success: false)))
        }
    }
    
    func request<T: Codable>(urlRequest: URLRequest, completion: @escaping(Result<T, ErrorInfo>)->()) {
        AppHUD.show()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            AppHUD.hide()
            printDataResponse(response, urlRequest, data: data, error: error)
            
            self.handler(data: data, error: error, completion: completion)
        }.resume()
    }
}



