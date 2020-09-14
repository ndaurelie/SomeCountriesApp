//
//  FilterSuccessAndTransformError.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    /// Filters out responses that have the specified `statusCode` 200 or 404.
    func filterSuccessAndTransformError() -> Single<Element> {
        return flatMap { .just(try $0.filterSuccessAndTransformError()) }
    }
}

public extension Response {
    
    func filterSuccessAndTransformError() throws -> Response {
        guard (statusCode == 200 || statusCode == 404) else {
            throw MoyaError.statusCode(self)
        }
        return self
    }
}
