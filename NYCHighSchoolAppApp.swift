//
//  NYCHighSchoolAppApp.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI

struct StartingViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> StartingViewController {
        return StartingViewController()
    }

    func updateUIViewController(_ uiViewController: StartingViewController, context: Context) {
    }
}

@main
struct NYCHighSchoolAppApp: App {
    var body: some Scene {
        WindowGroup {
            StartingViewControllerWrapper()
        }
    }
}
