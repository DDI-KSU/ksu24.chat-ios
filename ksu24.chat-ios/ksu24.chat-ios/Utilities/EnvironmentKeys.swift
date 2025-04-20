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

private struct isBottomTabBarHiddenKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var profileID: UUID? {
        get { self[ProfileIDKey.self] }
        set { self[ProfileIDKey.self] = newValue }
    }
}

extension EnvironmentValues {
    var isBottomTabBarHidden: Bool {
        get { self[isBottomTabBarHiddenKey.self] }
        set { self[isBottomTabBarHiddenKey.self] = newValue }
    }
}
