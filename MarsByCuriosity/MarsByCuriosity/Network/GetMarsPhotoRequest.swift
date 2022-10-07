//
//  GetMarsPhotoRequest.swift
//  MarsByCuriosity
//
//

import Foundation

final class GetMarsPhotoRequest {
    private let date: String?
    private let camera: RoverCamera
    private let page: Int
    private let completion: (GetMarsPhotoResponse) -> ()
    
    init(by date: String?, camera: RoverCamera, page: Int, completion: @escaping (GetMarsPhotoResponse) -> ()) {
        self.date = date
        self.camera = camera
        self.page = page
        self.completion = completion
    }
    
    func runRequest() {
        guard var urlComponents = URLComponents(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos") else { return }
        
        var queryItems = [URLQueryItem(name: "earth_date", value: date)]
        
        queryItems.append(URLQueryItem(name: "api_key", value: AppConstants.apiKey))
        
        if camera != .all {
            queryItems.append(URLQueryItem(name: "camera", value: camera.rawValue))
        }
        
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        NetworkRequest().request(urlRequest: URLRequest(url: url)) { (result: Result<GetMarsPhotoResponse?, ErrorInfo>) in
            switch result {
                case .success(let response):
                    guard let response = response else { return }
                    
                    self.completion(response)
                case .failure(let errorInfo):
                    AlertManager.shared.showError(errorInfo.message)
            }
        }
    }
}
