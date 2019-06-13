//
//  Alamofire+Extensions.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any, withDataKey dKey: String?)
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any, withCollectionKey key: String?, withDataKey dKey: String?) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any, withCollectionKey cKey: String?, withDataKey dKey: String?) -> [Self] {
        var collection: [Self] = []
        if let wrapperJson = representation as? [String : Any],
            let key = cKey,
            let data = wrapperJson[key] as? [[String : Any]] {
            for items in data {
                if let item = Self(response: response, representation: items, withDataKey: dKey) {
                    collection.append(item)
                }
            }
        } else {
            if let representation = representation as? [[String: Any]] {
                for itemRepresentation in representation {
                    if let item = Self(response: response, representation: itemRepresentation, withDataKey: dKey) {
                        collection.append(item)
                    }
                }
            }
        }
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseObject<T: ResponseObjectSerializable>(
        withDataKey dKey: String? = nil,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response, let responseObject = T(response: response, representation: jsonObject, withDataKey: dKey) else {
                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        withCollectionKey cKey: String? = nil,
        withDataKey dKey: String? = nil,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(BackendError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(from: response, withRepresentation: jsonObject, withCollectionKey: cKey, withDataKey: dKey))
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

extension DataRequest {
    @discardableResult
    func responseNoModel(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<Any>  ) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<Any> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            return .success(jsonObject)
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
