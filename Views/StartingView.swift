//
//  ContentView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//
//

import UIKit
import SwiftUI

class StartingViewController: UIViewController {
    override func viewDidLoad() {

        
        super.viewDidLoad()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.presentMainView()
        })

        view.backgroundColor = .customYellow

        let titleLabel = UILabel()
        titleLabel.text = "NYC High Schools"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Learn about schools in your area"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        let spacerView = UIView()
        view.addSubview(spacerView)
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spacerView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            spacerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spacerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    

    
    @objc func presentMainView () {
        let vc = UIHostingController(rootView: HighSchoolListView())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
