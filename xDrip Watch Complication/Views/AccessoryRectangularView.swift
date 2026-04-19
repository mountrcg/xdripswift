//
//  AccessoryRectangularView.swift
//  xDrip Watch Complication Extension
//
//  Created by Paul Plant on 4/3/24.
//  Copyright © 2024 Johan Degraeve. All rights reserved.
//

import Foundation
import SwiftUI

extension XDripWatchComplication.EntryView {
    @ViewBuilder
    
    var accessoryRectangularView: some View {
        ZStack {
            if entry.widgetState.liveDataIsEnabled {
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 4) {
                            Text("\(entry.widgetState.bgValueStringInUserChosenUnit())\(entry.widgetState.trendArrow()) ")
                                .font(.system(size: entry.widgetState.isSmallScreen() ? 20 : 24)).bold()
                                .foregroundStyle(entry.widgetState.bgTextColor())
                            
                            Text(entry.widgetState.deltaChangeStringInUserChosenUnit())
                                .font(.system(size: entry.widgetState.isSmallScreen() ? 20 : 24)).fontWeight(.semibold)
                                .foregroundStyle(.colorPrimary)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Text("\(entry.widgetState.bgReadingDate?.formatted(date: .omitted, time: .shortened) ?? "--:--")")
                            .font(.system(size: entry.widgetState.isSmallScreen() ? 15 : 17))
                            .foregroundStyle(.colorPrimary)
                            .minimumScaleFactor(0.2)
                    }
                    .padding(0)
                    
                    GlucoseChartView(glucoseChartType: .watchAccessoryRectangular, bgReadingValues: entry.widgetState.bgReadingValues, bgReadingDates: entry.widgetState.bgReadingDates, isMgDl: entry.widgetState.isMgDl, urgentLowLimitInMgDl: entry.widgetState.urgentLowLimitInMgDl, lowLimitInMgDl: entry.widgetState.lowLimitInMgDl, highLimitInMgDl: entry.widgetState.highLimitInMgDl, urgentHighLimitInMgDl: entry.widgetState.urgentHighLimitInMgDl, liveActivityType: nil, hoursToShowScalingHours: nil, glucoseCircleDiameterScalingHours: nil, overrideChartHeight: entry.widgetState.overrideChartHeight(), overrideChartWidth: entry.widgetState.overrideChartWidth(), highContrast: nil)
                    
                    if entry.widgetState.keepAliveIsDisabled {
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: entry.widgetState.isSmallScreen() ? 12 : 14))
                            
                            Text(Texts_WatchComplication.keepAliveDisabled)
                                .font(.system(size: entry.widgetState.isSmallScreen() ? 12 : 14))
                                .multilineTextAlignment(.leading)
                        }
                        .foregroundStyle(.teal)
                        .padding(0)
                    }
                }
            } else {
                let isSmall = entry.widgetState.isSmallScreen()
                let headerFont: Font = .system(size: isSmall ? 16 : 18)
                let bodyFont: Font = .system(size: isSmall ? 10 : 14)

                VStack(alignment: .center, spacing: 2) {
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(headerFont).bold()

                        Text(Texts_WatchComplication.liveDataDisabled)
                            .font(headerFont).bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                    }
                    .foregroundStyle(.teal)
                    .padding(0)

                    instructionsText(bodyFont: bodyFont)
                }
            }
        }
        .widgetBackground(backgroundView: Color.clear)
    }

    private func instructionsText(bodyFont: Font) -> Text {
        let plain = Color("colorPrimary")
        let emph = Color.white

        let goTo = Text(Texts_WatchComplication.goTo).font(bodyFont).foregroundColor(plain)
        let app = Text(" \(ConstantsHomeView.applicationName)").font(bodyFont).bold().foregroundColor(emph)
        let arrow1 = Text(" -> ").font(bodyFont).foregroundColor(plain)
        let settings = Text(Texts_WatchComplication.settings).font(bodyFont).bold().foregroundColor(emph)
        let arrow2 = Text(" -> ").font(bodyFont).foregroundColor(plain)
        let watch = Text(Texts_WatchComplication.appleWatch + " ").font(bodyFont).bold().foregroundColor(emph)
        let toEnable = Text(Texts_WatchComplication.toEnable).font(bodyFont).foregroundColor(plain)

        return goTo + app + arrow1 + settings + arrow2 + watch + toEnable
    }
}
