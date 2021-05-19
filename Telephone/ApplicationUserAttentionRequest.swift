//
//  ApplicationUserAttentionRequest.swift
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

import AppKit

final class ApplicationUserAttentionRequest {
    private var request: Int?

    private let application: NSApplication
    private let center: NotificationCenter

    init(application: NSApplication, center: NotificationCenter) {
        self.application = application
        self.center = center
        center.addObserver(
            self,
            selector: #selector(didBecomeAcitve),
            name: NSApplication.didBecomeActiveNotification,
            object: application
        )
    }

    deinit {
        center.removeObserver(self)
    }

    @objc private func didBecomeAcitve(_ notification: Notification) {
        request = nil
    }
}

extension ApplicationUserAttentionRequest: UserAttentionRequest {
    func start() {
        if !application.isActive && request == nil {
            request = application.requestUserAttention(.criticalRequest)
        }
    }

    func stop() {
        if let request = request {
            application.cancelUserAttentionRequest(request)
        }
        request = nil
    }
}
