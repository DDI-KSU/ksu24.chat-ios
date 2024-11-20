//
//  EnvironmentKeys.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import Foundation
import SwiftUI

private struct ProfileIDKey: EnvironmentKey {
    static let defaultValue: UUID? = nil
}

extension EnvironmentValues {
    var profileID: UUID? {
        get { self[ProfileIDKey.self] }
        set { self[ProfileIDKey.self] = newValue }
    }
}
