//
//  ZakazkyListView.swift
//  Staspo_iOS
//
//  Created by Jan Mikulenka on 21.10.2025.
//

import SwiftUI
import Combine

struct ZakazkyListView: View {
    @StateObject var viewModel: ZakazkyViewModel

    var body: some View {
        List(viewModel.zakazky) { z in
            NavigationLink {
                ZakazkaDetailView(zakazka: z)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(z.nazev)
                        .font(.headline)
                    Text(format(date: z.datum))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .overlay {
            if viewModel.isLoading { ProgressView() }
        }
        .task {           // načti data při zobrazení
            viewModel.load()
        }
    }

    private func format(date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}

struct ZakazkaDetailView: View {
    let zakazka: Zakazka
    var body: some View {
        VStack(spacing: 16) {
            Text(zakazka.nazev).font(.title2)
            Text("Detail zakázky (placeholder)")
            Spacer()
        }
        .padding()
        .navigationTitle("Zakázka")
    }
}
