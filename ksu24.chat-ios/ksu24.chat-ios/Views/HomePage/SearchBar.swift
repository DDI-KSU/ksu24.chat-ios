//
//  SearchBar\.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 22/11/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(.systemGray2))
            
            TextField("Search for chat...", text: $searchText)
                .overlay(
                    cancelButton
                        .onTapGesture {
                            UIApplication.shared.endEiting()
                            searchText = ""
                        },
                    alignment: .trailing
                )
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.clear)
                .strokeBorder(Color(.systemGray3).opacity(0.8), style: .init(lineWidth: 1))
                .frame(height: 30)
        )
    }
    
    private var cancelButton: some View {
        Image(systemName: "xmark.circle")
            .padding()
            .offset(x: 10)
            .foregroundStyle(Color(.systemGray2))
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
    }
}

extension UIApplication {
    func endEiting() {
        sendAction(
            #selector (UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
