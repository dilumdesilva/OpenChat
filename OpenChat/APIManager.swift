//
//  APIManager.swift
//  OpenChat
//
//  Created by Dilum De Silva on 2022-12-16.
//

import OpenAISwift
import Foundation

final class APIManager {
    static let shared = APIManager()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(for input: String,
                            completion: @escaping (Result <String, Error>) -> Void) {
        
        client?.sendCompletion(with: input, model: .gpt3(.davinci), completionHandler: { result in
            switch result {
            case .success(let model):
                let response = model.choices.first?.text ?? "Sorry, I didn't quiet understand"
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
    }
    
}
