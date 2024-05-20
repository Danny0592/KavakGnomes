//
//  KavakGnomesApiClient.swift
//  KavakGnomes
//
//  Created by daniel ortiz millan on 17/05/24.
// file

import Foundation

class GnomesApiClient {
    
    func getGnomes(completion: @escaping (Result<GnomesModel, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                let result = try JSONDecoder().decode(GnomesModel.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
        }
        .resume()
    }
}




/*import Foundation

class ApiClient {
    
    func getUser(completion: @escaping (Result<GnomesModel, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
    }
    
}*/
