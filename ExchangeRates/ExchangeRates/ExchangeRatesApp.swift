//
//  ExchangeRatesApp.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

@main
struct ExchangeRatesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Rates().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
