//
//  TabRootViews.swift
//  Staspo_iOS
//
//  Created by Jan Mikulenka on 21.10.2025.
//

import SwiftUI
import Combine

struct TabRootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ZakazkyListView(viewModel: ZakazkyViewModel())
                    .navigationTitle("Zakázky")
            }
            .tabItem {
                Label("Zakázky", systemImage: "folder.badge.person.crop")
            }

            NavigationStack {
                UkolyListView(viewModel: UkolyViewModel())
                    .navigationTitle("Úkoly")
            }
            .tabItem {
                Label("Úkoly", systemImage: "checklist")
            }
        }
    }
}

#Preview {
    TabRootView()
}
