//
//  Rates.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct Rates: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Month.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Month.date, ascending: true) ]) private var months: FetchedResults<Month>
    @State var showEditRates = false
    @State var on = false
    @State var rate = Rate.init(baseRate: 1.00, exchangeRate: 1.23, baseSelect: .EUR, convert2JPY: 100.00, convert2GBP: 0.94, convert2MXN: 20.00, convert2USD: 1.23, convert2CAD: 1.52)
    @State var graphPoints: [CGFloat] = []
    @State var dates: [String] = []
    
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
                    Text("πͺπΊ -> πΊπΈ").font(.largeTitle)
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
                    Graph(on: $on, points: graphPoints)
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
                    Text("Sample")
                })
            })
            .sheet(isPresented: $showEditRates) {
                EditRates(rate: $rate).environment(\.managedObjectContext, viewContext)
            }
            .onAppear(perform: {
                loadLatestRates()
                setUpCoreData()
                setUpGraphPoints()
            })
        }
    }
    
    func loadLatestRates() {
        let APIKey = "6fed17b8bdf432a8e7961275b7b5c2c0"
        let baseRate = "EUR"
        let symbols = "JPY,GBP,MXN,USD,CAD,EUR"
        let baseURL = "http://data.fixer.io/api/latest"
        let latestRateURL = baseURL + "?access_key=" + APIKey + "&base=" + baseRate + "&symbols=" + symbols
        //http://data.fixer.io/api/latest?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=USD
                
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
    
    func setUpCoreData() {
        if months.count == 12 {
            return
        }
        for i in 0..<12 {
            let month = Month(context: viewContext)
            month.id = Int16(i)
            month.rate = Double.random(in: 0...2)
            month.date = "2021-04-10"
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configureNext12Dates() {
        dates = []
        let rate_date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let rdate = formatter.string(from: rate_date)
        let dateArray = rdate.components(separatedBy: "-")
        var year = Int(dateArray[0])!
        var month = Int(dateArray[1])!
        year -= 1
        month += 1
        months.forEach { monthIndex in
            let strMonth = String(format: "%02d", month)
            let strDate = "\(year)-" + strMonth + "-01"
            dates.append(strDate)
            monthIndex.date = strDate
            if month == 12 {
                year += 1
                month = 0
            }
            month += 1
        }
    }
    
    func setUpGraphPoints() {
        graphPoints = []
        let APIKey = "6fed17b8bdf432a8e7961275b7b5c2c0"
        let baseRate = "EUR"
        let symbols = "USD"
        let baseURL = "http://data.fixer.io/api/"
        //http://data.fixer.io/api/2021-04-10?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=USD
        configureNext12Dates()
        
        months.forEach { month in
            
            let index = Int(month.id)
            let defaultSession = URLSession(configuration: .default)
            var dataTask: URLSessionDataTask?
            let historicalRateURL = baseURL + dates[index] + "?access_key=" + APIKey + "&base=" + baseRate + "&symbols=" + symbols
            dataTask?.cancel()
            guard let url = URL(string: historicalRateURL) else { return }
                        
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
                        month.rate = array["USD"] as! Double
                        graphPoints.append(CGFloat(month.rate))
                    }
                }
            }
            dataTask?.resume()
        }
    }
}

struct Rates_Previews: PreviewProvider {
    static var previews: some View {
        Rates()
    }
}
