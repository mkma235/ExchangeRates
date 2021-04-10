//
//  EditRates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct EditRates: View {
    @Environment (\.presentationMode) var presentationMode
    @State private var date = Date()
    @Binding var rate: BaseRate.Base
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Base Rate")
                        .bold()
                        .underline()
                    Picker("Base Rate", selection: $rate) {
                        ForEach(BaseRate.Base.allCases, id: \.self) { rate in
                            Text(rate.rawValue).tag(rate)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Converting Rates")
                        .bold()
                        .underline()
                    HStack {
                        Text("🇯🇵")
                        Spacer()
                        if rate == .USD {
                            Text("1 USD = X JPY")
                        } else if rate == .EUR {
                            Text("1 EUR = X JPY")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("🇬🇧")
                        Spacer()
                        if rate == .USD {
                            Text("1 USD = X GBP")
                        } else if rate == .EUR {
                            Text("1 EUR = X GBP")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("🇲🇽")
                        Spacer()
                        if rate == .USD {
                            Text("1 USD = X MXN")
                        } else if rate == .EUR {
                            Text("1 EUR = X MXN")
                        }
                        Spacer()
                    }
                }
                .padding()
                DatePicker("Sample Date", selection: $date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
            .navigationTitle("Rate Sampling")
            .toolbar(content: {
                Button(action: {
                    print("Save New Rate To Graph")
                    print(date)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let datePicked = formatter.string(from: self.date)
                    print("TEST DATE PICKER FORMATTER: ")
                    print(datePicked)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "centsign.circle.fill")
                })
            })
        }
    }
}

struct EditRates_Previews: PreviewProvider {
    static var previews: some View {
        EditRates(rate: .constant(.USD))
    }
}
