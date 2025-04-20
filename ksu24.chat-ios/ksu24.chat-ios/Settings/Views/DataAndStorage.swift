//
//  DataAndStorage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/12/2024.
//

import SwiftUI

struct DataAndStorage: View {
    var usageData = CacheManager.shared.cacheUsageByType()
    
    var body: some View {
        StoragePieChart(usageData: usageData)
    }
}

#Preview {
    DataAndStorage()
}
