//
//  EditRates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct EditRates: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    @FetchRequest(entity: Month.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Month.date, ascending: true) ]) private var months: FetchedResults<Month>
    @State private var date = Date()
    @Binding var rate: Rate
    
    var body: some View {
        NavigationView {
            List {
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
                        Text(bRate + " EUR = " + jpRate + " JPY")
                        Spacer()
                    }
                    HStack {
                        Text("🇬🇧")
                        Spacer()
                        let gbp_rate = Double(round(100*rate.convert2GBP)/100)
                        let gbRate = String(format: "%.2f", gbp_rate)
                        Text(bRate + " EUR = " + gbRate + " GBP")
                        Spacer()
                    }
                    HStack {
                        Text("🇲🇽")
                        Spacer()
                        let mxn_rate = Double(round(100*rate.convert2MXN)/100)
                        let mxRate = String(format: "%.2f", mxn_rate)
                        Text(bRate + " EUR = " + mxRate + " MXN")
                        Spacer()
                    }
                    HStack {
                        Text("🇺🇸")
                        Spacer()
                        let usd_rate = Double(round(100*rate.convert2USD)/100)
                        let usRate = String(format: "%.2f", usd_rate)
                        Text(bRate + " EUR = " + usRate + " USD")
                        Spacer()
                    }
                    HStack {
                        Text("🇨🇦")
                        Spacer()
                        let cad_rate = Double(round(100*rate.convert2CAD)/100)
                        let cdRate = String(format: "%.2f", cad_rate)
                        Text(bRate + " EUR = " + cdRate + " CAD")
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
                    updateGraphPoint()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "centsign.circle.fill")
                })
            })
        }
    }
    
    func updateGraphPoint() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let datePicked = formatter.string(from: self.date)
        months.first?.date = datePicked
        let APIKey = "6fed17b8bdf432a8e7961275b7b5c2c0"
        let baseRate = "EUR"
        let symbols = "USD"
        let baseURL = "http://data.fixer.io/api/"
        //http://data.fixer.io/api/2021-04-10?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=USD
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let historicalRatesURL = baseURL + datePicked + "?access_key=" + APIKey + "&base=" + baseRate + "&symbols=" + symbols
        dataTask?.cancel()
        guard let url = URL(string: historicalRatesURL) else { return }
                        
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
                    months.first?.rate = array["USD"] as! Double
                }
            }
        }
        dataTask?.resume()
    }
}

struct EditRates_Previews: PreviewProvider {
    static var previews: some View {
        EditRates(rate: .constant(.init(baseRate: 1.00, exchangeRate: 1.23, baseSelect: .EUR, convert2JPY: 100.00, convert2GBP: 0.94, convert2MXN: 20.00, convert2USD: 1.23, convert2CAD: 1.52)))
    }
}
