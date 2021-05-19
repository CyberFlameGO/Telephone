//
//  PKCS7SignatureValidation.swift
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

import Foundation

final class PKCS7SignatureValidation: NSObject {
    private let origin: ReceiptValidation
    private let certificate: Data

    init(origin: ReceiptValidation, certificate: Data) {
        self.origin = origin
        self.certificate = certificate
    }
}

extension PKCS7SignatureValidation: ReceiptValidation {
    func validateReceipt(_ receipt: Data, completion: @escaping (_ result: Result, _ expiration: Date) -> Void) {
        if PKCS7Container(data: receipt)!.isSignatureValid(withRootCertificate: certificate) {
            origin.validateReceipt(receipt, completion: completion)
        } else {
            completion(.receiptIsInvalid, Date.distantPast)
        }
    }
}
