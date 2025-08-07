//
//  LookAroundViewController.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import UIKit
import MapKit

class LookAroundViewController: UIViewController {
    private let scene: MKLookAroundScene

    init(scene: MKLookAroundScene) {
        self.scene = scene
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let lookAroundVC = MKLookAroundViewController(scene: scene)
        addChild(lookAroundVC)
        lookAroundVC.view.frame = view.bounds
        lookAroundVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(lookAroundVC.view)
        lookAroundVC.didMove(toParent: self)
    }
}
