//
//  UkolyViewModel.swift
//  Staspo_iOS
//
//  Created by Jan Mikulenka on 21.10.2025.
//

import Foundation
import Combine   // ⬅️ přidat

@MainActor
final class UkolyViewModel: ObservableObject {
    @Published var sekce: [UkolniSekce] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init() { load() }

    func load() {
        isLoading = true
        errorMessage = nil
        let today = Calendar.current.startOfDay(for: Date())
        let days = (0..<4).map { today.addingTimeInterval(Double($0) * 86400) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.sekce = days.map { d in
                UkolniSekce(den: d, ukoly: (0..<Int.random(in: 2...5)).map { i in
                    Ukol(id: "\(Int(d.timeIntervalSince1970))-\(i)", popis: "Úkon \(i+1)", fotek: Int.random(in: 0...3))
                })
            }
            self.isLoading = false
        }
    }
}

struct Ukol: Identifiable, Hashable {
    let id: String
    let popis: String
    let fotek: Int
}

struct UkolniSekce: Identifiable, Hashable {
    var id: Date { den }
    let den: Date
    let ukoly: [Ukol]
}
