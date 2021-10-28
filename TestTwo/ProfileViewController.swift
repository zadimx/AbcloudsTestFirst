//
//  ProfileViewController.swift
//  TestTwo
//
//  Created by Zinovatny Maksym on 15.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var followButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    followButton.layer.masksToBounds = true
    followButton.layer.borderColor = UIColor.blue.cgColor
    followButton.layer.cornerRadius = 15
    followButton.layer.borderWidth = 1
  }

  @IBAction func backButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
