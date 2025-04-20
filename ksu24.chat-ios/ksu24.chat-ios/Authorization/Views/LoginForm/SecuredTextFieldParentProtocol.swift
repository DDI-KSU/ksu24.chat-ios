//
//  SecuredTextFieldParentProtocol.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 21/11/2024.
//

import SwiftUI

protocol SecuredTextFieldParentProtocol {
    var hideKeyboard: (() -> Void)? { get set }
}
