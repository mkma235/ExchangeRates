//
//  Rates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct Rates: View {
    
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
                    Text("🇺🇸").font(.largeTitle)
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
                    Text("1 USD = X EUR").font(.largeTitle)
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
                    print("Money!")
                }, label: {
                    Image(systemName: "centsign.circle")
                })
            })
        }
    }
}

struct Rates_Previews: PreviewProvider {
    static var previews: some View {
        Rates()
    }
}
