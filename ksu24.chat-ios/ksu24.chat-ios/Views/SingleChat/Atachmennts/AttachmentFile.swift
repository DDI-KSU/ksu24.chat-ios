//
//  AttachmentFile.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AttachmentFile: View {
    var attachment: File
    var message: Message
    var baseURLString: String = "https://ksu24.kspu.edu"
    var currentUserID: UUID
    
    @Environment(\.profileID) var profileID
    
    @State private var isDownloading: Bool = false
    @State private var downloadProgress: Double = 0.0
    @State private var localFileURL: URL?
    @State private var showQuickLook: Bool = false
    
    
    var body: some View {
        VStack {
           HStack {
               Image(systemName: iconName(for: attachment.originalFilename))
                   .resizable()
                   .frame(width: 24, height: 24)
                   .foregroundColor(.blue)

               VStack(alignment: .leading) {
                   Text(attachment.originalFilename)
                       .font(.system(size: 16)).bold()
                       .lineLimit(1)
                       .foregroundColor(.black)

                   Text("\(attachment.fileSize / 1024) MB")
                       .font(.caption)
                       .foregroundColor(Color(.systemGray3))
                   
                   Text(message.content)
                       .font(.system(size: 14))
                       .foregroundColor(.primary)
               }

               Spacer()

               if isDownloading {
                   ProgressView(value: downloadProgress)
                       .progressViewStyle(CircularProgressViewStyle())
               } else {
                   Button(action: {
                       openFile(urlString: baseURLString + attachment.file)
                   }) {
                       Image(systemName: "arrow.down.circle")
                           .resizable()
                           .frame(width: 24, height: 24)
                           .foregroundColor(.blue)
                   }
               }
           }
           .padding(8)
//           .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: profileID ?? UUID())))
//           .background(Color(.systemGray4))
        }
        .sheet(isPresented: $showQuickLook) {
           if let fileURL = localFileURL {
               QuickLookPreview(url: fileURL)
           }
        }
    }

    func iconName(for fileName: String) -> String {
        if let ext = fileName.split(separator: ".").last?.lowercased() {
            switch ext {
            case "pdf":
                return "doc.richtext"
            case "doc", "docx":
                return "doc.text"
            case "xls", "xlsx":
                return "doc.plaintext"
            case "ppt", "pptx":
                return "doc.on.clipboard"
            default:
                return "doc"
            }
        }
        return "doc"
    }

    func openFile(urlString: String) {
        guard let url = URL(string: urlString) else { return }

                isDownloading = true

                downloadFile(from: url) { result in
                    DispatchQueue.main.async {
                        self.isDownloading = false

                        switch result {
                        case .success(let localURL):
                            self.localFileURL = localURL
                            self.showQuickLook = true
                        case .failure(let error):
                            print("Download error: \(error)")
                        }
                    }
                }
    }
    
    func downloadFile(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
           let task = URLSession.shared.downloadTask(with: url) { tempLocalUrl, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }

               guard let tempLocalUrl = tempLocalUrl else {
                   completion(.failure(NSError(domain: "DownloadError", code: -1, userInfo: nil)))
                   return
               }

               let fileManager = FileManager.default
               let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

               let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
               
               print(destinationURL)

               do {
                   if fileManager.fileExists(atPath: destinationURL.path) {
                       try fileManager.removeItem(at: destinationURL)
                   }
                   try fileManager.copyItem(at: tempLocalUrl, to: destinationURL)
                   completion(.success(destinationURL))
               } catch {
                   completion(.failure(error))
               }
           }

           let observation = task.progress.observe(\.fractionCompleted) { progress, _ in
               DispatchQueue.main.async {
                   self.downloadProgress = progress.fractionCompleted
               }
           }

           task.resume()
       }
}
//#Preview {
//    AttachmentFile()
//}
