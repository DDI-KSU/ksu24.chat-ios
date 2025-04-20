//
//  StoragePieChart.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/12/2024.
//

import SwiftUI
import Charts



struct StoragePieChart: View {
    @State var usageData: [CacheUsage]
    
    @State private var selectedAngle: Double?
    
    @State var totalSizeInMB: Double
    
    private let categoryRanges: [(category: String, range: Range<Double>)]
    
    init(usageData: [CacheUsage]) {
        self.usageData = usageData
        var total: Double = 0
        categoryRanges = usageData.map {
            let newTotal = total + $0.size
            let result = (category: $0.cacheType,
                          range: Double(total) ..< Double(newTotal))
            
            total = newTotal
            return result
        }
        self.totalSizeInMB = Double(total)
    }
    
    var selectedItem: CacheUsage? {
        guard let selectedAngle else { return nil }
        
        if let selected = categoryRanges.firstIndex(where: {
            $0.range.contains(selectedAngle)
        }) {
            return usageData[selected]
        }
        
        return nil
    }

    var body: some View {
        VStack {
            Chart(usageData, id: \.self) { item in
                SectorMark(
                    angle: .value("Size", item.size),
                    innerRadius: .ratio(0.6),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Category", item.cacheType))
                .opacity(item.cacheType == selectedItem?.cacheType ? 1 : 0.5)
            }
            .scaledToFit()
            .chartLegend(alignment: .center, spacing: 16)
            .chartAngleSelection(value: $selectedAngle)
            .chartBackground { chatProxy in
                GeometryReader { geometry in
                    if let anchor = chatProxy.plotFrame {
                        let frame = geometry[anchor]
                        
                        titleView
                            .position(x: frame.midX, y: frame.maxY * 0.525)
                    }
                }
            }
            
        }
        .padding()
    }
    
    private var titleView: some View {
            let title = selectedItem?.cacheType ?? "Total"
            let size = selectedItem?.size ?? totalSizeInMB 
            
            return VStack {
                Text(title)
                    .font(.title)
                    .bold()
                Text(String(format: "%.2f MB", size / 1024 / 1024))
                    .font(.callout)
            }
        }
}


