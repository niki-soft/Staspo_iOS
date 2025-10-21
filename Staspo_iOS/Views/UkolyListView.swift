//
//  UkolyListView.swift
//  Staspo_iOS
//
//  Created by Jan Mikulenka on 21.10.2025.
//

import SwiftUI

struct UkolyListView: View {
    @StateObject var viewModel: UkolyViewModel
    @State private var expanded: Set<Date> = []

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Načítám…")
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView("Chyba", systemImage: "exclamationmark.triangle", description: Text(error))
            } else {
                List {
                    ForEach(viewModel.sekce) { sekce in
                        Section {
                            if expanded.contains(sekce.den) {
                                ForEach(sekce.ukoly) { u in
                                    NavigationLink {
                                        UkonDetailView(nazev: u.popis)
                                    } label: {
                                        HStack {
                                            Text(u.popis)
                                            Spacer()
                                            if u.fotek > 0 {
                                                Label("\(u.fotek)", systemImage: "photo.on.rectangle")
                                                    .labelStyle(.titleAndIcon)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                    }
                                }
                            } else {
                                Text("Rozklikni pro úkony")
                                    .foregroundStyle(.secondary)
                            }
                        } header: {
                            Button {
                                toggle(sekce.den)
                            } label: {
                                HStack {
                                    Image(systemName: expanded.contains(sekce.den) ? "chevron.down" : "chevron.right")
                                        .font(.subheadline)
                                    Text(sekce.den, style: .date)
                                        .font(.headline)
                                }
                                .foregroundStyle(.primary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .refreshable { viewModel.load() }
            }
        }
    }

    private func toggle(_ date: Date) {
        if expanded.contains(date) {
            expanded.remove(date)
        } else {
            expanded.insert(date)
        }
    }
}

struct UkonDetailView: View {
    let nazev: String

    var body: some View {
        List {
            Section(nazev) {
                Text("Detail úkonu – zde budou metadata, stav, atd.")
            }
            Section("Fotky") {
                // TODO: přidání fotek (PhotosPicker / Camera)
                Button {
                    // akce přidat fotku
                } label: {
                    Label("Přidat fotku", systemImage: "camera")
                }
            }
        }
        .navigationTitle("Detail úkonu")
    }
}
