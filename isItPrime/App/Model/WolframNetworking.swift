//
//  WolframNetworking.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct WolframNetworking {

    func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
      var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
      components.queryItems = [
        URLQueryItem(name: "input", value: query),
        URLQueryItem(name: "format", value: "plaintext"),
        URLQueryItem(name: "output", value: "JSON"),
        URLQueryItem(name: "appid", value: "T99PP8-GGA4UWK3JG"),
      ]
      URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
        callback(
          data
            .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
        )
        }
        .resume()
    }

    func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
      wolframAlpha(query: "prime \(n)") { result in
        callback(
          result
            .flatMap {
              $0.queryresult
                .pods
                .first(where: { $0.primary == .some(true) })?
                .subpods
                .first?
                .plaintext
            }
            .flatMap(Int.init)
        )
      }
    }
}
