//
//  APIService.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Foundation
import Combine

// MARK: - API Endpoint

enum APIEndpoint {
    static let baseURL = "https://api.github.com/"
    
    case searchRepository(query: String, perPage: Int)
    
    var request: URLRequest {
        switch self {
        case .searchRepository(let query, let perPage):
            let path =  "search/repositories?q=\(query)&per_page=\(perPage)"
            let url = URL(string: APIEndpoint.baseURL + path)!

            var request =  URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
            
            return request
        }
    }
}

// MARK: - API Error

enum APIError: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case addressUnreachable(URL)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
}

protocol APIProtocol {
    func fetchRepositories(query: String, perPage: Int) -> AnyPublisher<SearchItems, APIError>
}

// MARK: - API Networking

class API: APIProtocol {
    
    static let shared = API()
    
    private init() {}
    
    private let decoder = JSONDecoder()
    
    func fetchRepositories(query: String, perPage: Int) -> AnyPublisher<SearchItems, APIError> {
        let request = APIEndpoint.searchRepository(query: query, perPage: perPage).request
        
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: SearchItems.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return APIError.addressUnreachable(request.url!)
                default: return APIError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
}
