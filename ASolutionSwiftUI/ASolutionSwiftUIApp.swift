//
//  ASolutionSwiftUIApp.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//

import SwiftUI

@main
struct ASolutionSwiftUIApp: App {
    init() {
        setupNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }

    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.primary)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
