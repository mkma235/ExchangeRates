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
    @Binding var rate: Rate
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Base Rate")
                        .bold()
                        .underline()
                    Picker("Base Rate", selection: $rate.baseSelect) {
                        ForEach(Rate.Base.allCases, id: \.self) { rate in
                            Text(rate.rawValue).tag(rate)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                let base_rate = Double(round(100*rate.baseRate)/100)
                let bRate = String(format: "%.2f", base_rate)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Converting Rates")
                        .bold()
                        .underline()
                    HStack {
                        Text("🇯🇵")
                        Spacer()
                        let jpy_rate = Double(round(100*rate.convert2JPY)/100)
                        let jpRate = String(format: "%.2f", jpy_rate)
                        if rate.baseSelect == .USD {
                            Text(bRate + " USD = " + jpRate + " JPY")
                        } else if rate.baseSelect == .EUR {
                            Text(bRate + " EUR = " + jpRate + " JPY")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("🇬🇧")
                        Spacer()
                        let gbp_rate = Double(round(100*rate.convert2GBP)/100)
                        let gbRate = String(format: "%.2f", gbp_rate)
                        if rate.baseSelect == .USD {
                            Text(bRate + " USD = " + gbRate + " GBP")
                        } else if rate.baseSelect == .EUR {
                            Text(bRate + " EUR = " + gbRate + " GBP")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("🇲🇽")
                        Spacer()
                        let mxn_rate = Double(round(100*rate.convert2MXN)/100)
                        let mxRate = String(format: "%.2f", mxn_rate)
                        if rate.baseSelect == .USD {
                            Text(bRate + " USD = " + mxRate + " MXN")
                        } else if rate.baseSelect == .EUR {
                            Text(bRate + " EUR = " + mxRate + " MXN")
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
        EditRates(rate: .constant(.init(baseRate: 1.00, exchangeRate: 1.23, baseSelect: .USD, convert2JPY: 100.00, convert2GBP: 0.94, convert2MXN: 20.00)))
    }
}
