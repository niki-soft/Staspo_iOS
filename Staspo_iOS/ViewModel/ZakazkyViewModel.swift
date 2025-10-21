//
//  ZakazkyViewModel.swift
//  Staspo_iOS
//
//  Created by Jan Mikulenka on 21.10.2025.
//

import Foundation
import Combine

@MainActor
final class ZakazkyViewModel: ObservableObject {
    @Published var zakazky: [Zakazka] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init() {
        load()
    }

    func load() {
        isLoading = true
        errorMessage = nil
        // TODO: Networking: zavolat API
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.zakazky = [
                Zakazka(id: 1, nazev: "Hermenice – meziskládka", datum: Date()),
                Zakazka(id: 2, nazev: "Vugrlov – multifunkční dům", datum: Date().addingTimeInterval(86400)),
                Zakazka(id: 3, nazev: "Oprava střechy – hala B", datum: Date().addingTimeInterval(2*86400))
            ]
            self.isLoading = false
        }
    }
}

struct Zakazka: Identifiable, Hashable {
    let id: Int
    let nazev: String
    let datum: Date
}
