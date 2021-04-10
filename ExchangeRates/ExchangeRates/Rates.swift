//
//  Rates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct Rates: View {
    @State var showEditRates = false
    @State var rate = Rate.init(baseRate: 1.00, exchangeRate: 1.23, baseSelect: .USD, convert2JPY: 100.00, convert2GBP: 0.94, convert2MXN: 20.00)
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("Base Rate")
                            .bold()
                            .underline()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    if rate.baseSelect == .USD {
                        Text("🇺🇸").font(.largeTitle)
                    } else if rate.baseSelect == .EUR {
                        Text("🇪🇺").font(.largeTitle)
                    }
                }
                .padding()
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("Latest Rate")
                            .bold()
                            .underline()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    let base_rate = Double(round(100*rate.baseRate)/100)
                    let bRate = String(format: "%.2f", base_rate)
                    let exchange_rate = Double(round(100*rate.exchangeRate)/100)
                    let eRate = String(format: "%.2f", exchange_rate)
                    if rate.baseSelect == .USD {
                        Text(bRate + " USD = " + eRate + " EUR").font(.largeTitle)
                    } else if rate.baseSelect == .EUR {
                        Text(bRate + " EUR = " + eRate + " USD").font(.largeTitle)
                    }
                }
                .padding()
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("Visual")
                            .bold()
                            .underline()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Image(systemName: "dollarsign.square")
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Rates")
            .toolbar(content: {
                Button(action: {
                    showEditRates = true
                }, label: {
                    Image(systemName: "centsign.circle")
                })
            })
            .sheet(isPresented: $showEditRates) {
                EditRates(rate: $rate)
            }
        }
    }
}

struct Rates_Previews: PreviewProvider {
    static var previews: some View {
        Rates()
    }
}
