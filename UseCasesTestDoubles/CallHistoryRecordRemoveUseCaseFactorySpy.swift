//
//  CallHistoryRecordRemoveUseCaseFactorySpy.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2021 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import UseCases

public final class CallHistoryRecordRemoveUseCaseFactorySpy {
    public private(set) var invokedIdentifier: String?

    private let remove: UseCase

    public init(remove: UseCase) {
        self.remove = remove
    }
}

extension CallHistoryRecordRemoveUseCaseFactorySpy: CallHistoryRecordRemoveUseCaseFactory {
    public func make(identifier: String) -> UseCase {
        invokedIdentifier = identifier
        return remove
    }
}
