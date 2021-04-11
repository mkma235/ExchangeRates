//
//  Rates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct Rates: View {
    @State var showEditRates = false
    @State var on = false
    @State var rate = Rate.init(baseRate: 1.00, exchangeRate: 1.23, baseSelect: .EUR, convert2JPY: 100.00, convert2GBP: 0.94, convert2MXN: 20.00, convert2USD: 1.23, convert2CAD: 1.52)
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("Base Rate")
                            .bold()
                            .underline()
                            .padding()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Text("🇪🇺 -> 🇺🇸").font(.largeTitle)
                }
                .padding()
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("Latest Rate")
                            .bold()
                            .underline()
                            .padding()
                        Spacer()
                        Spacer()
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
                    Text(bRate + " EUR = " + eRate + " USD").font(.largeTitle)
                }
                .padding()
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("Visual")
                            .bold()
                            .underline()
                            .padding()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Graph(on: $on, points: [0.5,1.5,2.0,0.75,1,0.5,0.25,1.5,0.5,1,0,2])
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Rates")
            .toolbar(content: {
                Button(action: {
                    showEditRates = true
                    on = false
                    loadLatestRates()
                }, label: {
                    Image(systemName: "centsign.circle")
                })
            })
            .sheet(isPresented: $showEditRates) {
                EditRates(rate: $rate)
            }
            .onAppear(perform: {
                loadLatestRates()
            })
        }
    }
    func loadLatestRates() {
        let APIKey = "6fed17b8bdf432a8e7961275b7b5c2c0"
        let baseRate = "EUR"
        let symbols = "JPY,GBP,MXN,USD,CAD,EUR"
        let baseURL = "http://data.fixer.io/api/latest"
        let latestRateURL = baseURL + "?access_key=" + APIKey + "&base=" + baseRate + "&symbols=" + symbols
        //http://data.fixer.io/api/latest?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=GBP,JPY,USD
                
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
                    
        dataTask?.cancel()
        guard let url = URL(string: latestRateURL) else { return }
                    
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
                    
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                var response: [String: Any]?
                do {
                    response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch _ as NSError { return }
                guard let array = response!["rates"]! as? [String: Any] else { return }
                DispatchQueue.main.async {
                    rate.baseRate = array["EUR"] as! Double
                    rate.exchangeRate = array["USD"] as! Double
                    rate.convert2JPY = array["JPY"] as! Double
                    rate.convert2GBP = array["GBP"] as! Double
                    rate.convert2MXN = array["MXN"] as! Double
                    rate.convert2USD = array["USD"] as! Double
                    rate.convert2CAD = array["CAD"] as! Double
                }
            }
        }
        dataTask?.resume()
    }
}

struct Rates_Previews: PreviewProvider {
    static var previews: some View {
        Rates()
    }
}
