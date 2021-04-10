//
//  Rates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct Rates: View {
    @State var showEditRates = false
    @State var rate: BaseRate.Base = .USD
    
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
                    if rate == .USD {
                        Text("🇺🇸").font(.largeTitle)
                    } else if rate == .EUR {
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
                    if rate == .USD {
                        Text("1 USD = X EUR").font(.largeTitle)
                    } else if rate == .EUR {
                        Text("1 EUR = X USD").font(.largeTitle)
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
