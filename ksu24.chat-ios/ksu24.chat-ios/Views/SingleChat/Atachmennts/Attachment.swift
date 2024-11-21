//
//  Untitled.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AttachmentView: View {
    var attachment: File
    var withText: String

    var body: some View {
        if isImage(fileName: attachment.originalFilename) {
            AttachmentImage(urlString: attachment.file, withText: withText)
        } else {
            AttachmentFile(attachment: attachment, withText: withText)
        }
    }

    func isImage(fileName: String) -> Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "heic"]
        if let ext = fileName.split(separator: ".").last {
            return imageExtensions.contains(ext.lowercased())
        }
        return false
    }
}
