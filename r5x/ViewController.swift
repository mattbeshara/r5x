// Copyright 2021 Matt Beshara.
//
// This file is part of r5x.
//
// r5x is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// r5x is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with r5x.  If not, see <https://www.gnu.org/licenses/>.

import UIKit

class ViewController: UIViewController {
    private var observations: [AnyObject] = []
    private var counter = 0 { didSet { label.text = "\(counter)" } }

    lazy var label = with(UILabel()) {
        $0.textAlignment = .center
        $0.text = "No taps yet"
    }

    private func setupLabel() {
        view.addSubview(label)
        label.constrain {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            $0.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            $0.heightAnchor.constraint(equalToConstant: 44)
        ]}
    }

    lazy var sendButton = with(UIButton()) {
        $0.setTitle("Send", for: .normal)
        $0.backgroundColor = .blue
        observations.append($0.onTap.observe { self.counter += 1 })
    }

    private func setupSendButton() {
        view.addSubview(sendButton)
        sendButton.constrain {[
            $0.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            $0.widthAnchor.constraint(equalToConstant: 80),
            $0.heightAnchor.constraint(equalToConstant: 44)
        ]}
    }

    lazy var unobserveButton = with(UIButton()) {
        $0.setTitle("Empty observations array", for: .normal)
        $0.backgroundColor = .red
        observations.append($0.onTap.observe {
            self.observations = []
            self.label.text = "The Send button should no longer work"
        })
    }

    private func setupUnobserveButton() {
        view.addSubview(unobserveButton)
        unobserveButton.constrain {[
            $0.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 8),
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            $0.widthAnchor.constraint(equalToConstant: 240),
            $0.heightAnchor.constraint(equalToConstant: 44)
        ]}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupLabel()
        setupSendButton()
        setupUnobserveButton()
    }
}

