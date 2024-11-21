//
//  SecureTextField.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 21/11/2024.
//

import SwiftUI

enum Field: Hashable {
    case showPasswordField
    case hidePasswordField
}

enum Opacity: Double {
    case hide = 0.0
    case show = 1.0

    mutating func toggle() {
        switch self {
        case .hide:
            self = .show
        case .show:
            self = .hide
        }
    }
}

struct SecuredTextField: View {
    @FocusState private var focusedField: Field?
    
    @State var parent: SecuredTextFieldParentProtocol
    
    @State private  var     hidePasswordFieldOpacity = Opacity.show
    @State private  var     showPasswordFieldOpacity = Opacity.hide
    @State public   var     isSecured:          Bool = true
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                securedTextField
                
                Button(action: {
                    performToggle()
                }, label: {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .foregroundStyle(Color(.systemGray2))
                        .offset(x: -5, y: -2)
                })
            }
        }
        .onAppear {
            self.parent.hideKeyboard = hideKeyboard
        }
    }

    var securedTextField: some View {
        Group {
            SecureField("Password", text: $text)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .padding(.bottom, 7)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .hidePasswordField)
                .opacity(hidePasswordFieldOpacity.rawValue)

            TextField("Password", text: $text)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .padding(.bottom, 7)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .showPasswordField)
                .opacity(showPasswordFieldOpacity.rawValue)
        }
    }
    
    func hideKeyboard() {
        self.focusedField = nil
    }
    
    private func performToggle() {
        isSecured.toggle()

        if isSecured {
            focusedField = .hidePasswordField
        } else {
            focusedField = .showPasswordField
        }

        hidePasswordFieldOpacity.toggle()
        showPasswordFieldOpacity.toggle()
    }
}

