//
//  Result.swift
//  LemonStore
//
//  Created by Abubakr Haydar on 21/06/1443 AH.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum DataLayerError<E: Error & Decodable>: Error  {
    case backend (E)
    case network(String)
    case parsing(String, Int)
}
