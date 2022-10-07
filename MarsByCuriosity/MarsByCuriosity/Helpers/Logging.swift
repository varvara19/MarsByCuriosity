//
//  Logging.swift
//  MarsByCuriosity
//
//

import Foundation

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

func debug_separator() {
    #if DEBUG
    print("────────────────────────────────────────────────────────────────────────────")
    #endif
}

func printTest(_ object: Any = #function) {
    #if DEBUG
    Swift.print("TEST: \(object)")
    #endif
}

func printRequestInfo(_ urlRequest: URLRequest) {
    debug_separator()
    
    var requestText : String = "URL = \(urlRequest.url?.absoluteString ?? "")\n"
    
    requestText += "Headers: \n"
    if let headers = urlRequest.allHTTPHeaderFields {
        for header in headers {
            requestText += "\t\(header.key): \(header.value)\n"
        }
    }
    
    requestText += "\nBody: \n"
    if let body = urlRequest.httpBody,
       let json = try? JSONSerialization.jsonObject(with: body, options: []),
       let formattedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
       let formattedString = String(data: formattedData, encoding: .utf8) {
        requestText += formattedString
    } else {
        requestText += "\t<empty>"
    }
    requestText += "\n"
    
    print(requestText)
    
    debug_separator()
}

func print_cd(_ coreDictionary: CoreDictionary) {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: coreDictionary, options: .prettyPrinted) else { return }
    
    printResponseInfo(response: nil, data: jsonData)
}

func printResponseInfo(response: HTTPURLResponse?, data: Data?) {
    var responseText : String
    if let data = data,
       let json = try? JSONSerialization.jsonObject(with: data, options: []),
       let formattedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
       let formattedString = String(data: formattedData, encoding: .utf8) {
        responseText = formattedString
    } else {
        responseText = "<empty>"
    }
    
    if let response = response {
        print("Status code: \(response.statusCode) - \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
    }
    print("Response: \n\(responseText)")
    debug_separator()
}

func printError(_ error: Error?) {
    print("Response: \(error?.localizedDescription ?? "")")
}

func printDataResponse(_ dataResponse: URLResponse?, _ dataRequest: URLRequest, data: Data?, error: Error?) {
    printRequestInfo(dataRequest)
    
    if let response = dataResponse as? HTTPURLResponse,
       let data = data {
        printResponseInfo(response: response, data: data)
    } else {
        printError(error)
    }
}
