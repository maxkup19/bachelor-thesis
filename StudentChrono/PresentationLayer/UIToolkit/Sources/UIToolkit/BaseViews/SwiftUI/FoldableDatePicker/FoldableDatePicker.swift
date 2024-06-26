//
//  FoldableDatePicker.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SwiftUI

public struct FoldableDatePicker: View {
    
    @Binding private var date: Date?
    
    @State private var dateEnabled: Bool
    @State private var selectedDate: Date
    @State private var showDatePicker: Bool = false
    
    public init(date: Binding<Date?>) {
        self._date = date
        self.dateEnabled = date.wrappedValue != nil
        self.selectedDate = date.wrappedValue ?? .now
    }
    
    public var body: some View {
        Group {
            Toggle(isOn: $dateEnabled) {
                HStack {
                    FormImage(
                        .rectangle,
                        image: AppTheme.Images.calendar,
                        color: .blue
                    )
                    
                    VStack(alignment: .leading) {
                        Text("Deadline")
                            .font(.callout)
                        
                        if let date {
                            Text("\(date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.footnote)
                                .foregroundStyle(Color.accentColor)
                        }
                    }
                    
                    Spacer()
                }
            }
            .onTapGesture {
                if dateEnabled {
                    showDatePicker.toggle()
                }
            }
            
            if showDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: Date.now...
                )
                .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .onChange(of: dateEnabled) {
            if dateEnabled {
                selectedDate = .now
                showDatePicker = true
            } else {
                date = nil
                showDatePicker = false
            }
        }
        .onChange(of: selectedDate) {
            date = selectedDate
        }
    }
}

#if DEBUG

#Preview {
    FoldableDatePicker(date: .constant(nil))
}
#endif
