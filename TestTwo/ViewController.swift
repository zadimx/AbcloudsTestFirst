//
//  ViewController.swift
//  TestTwo
//
//  Created by Zinovatny Maksym on 13.10.2021.
//
//

import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var singInStackView: UIStackView!
  @IBOutlet weak var singUpStackView: UIStackView!
  
  @IBOutlet weak var singInEmailTextField: UITextField!
  @IBOutlet weak var singInPassTextField: UITextField!
  @IBOutlet weak var singInSubmitButton: UIButton!
  
  @IBOutlet weak var singUpNameTextField: UITextField!
  @IBOutlet weak var singUpPhoneNumberTextField: UITextField!
  @IBOutlet weak var singUpEmailTextField: UITextField!
  @IBOutlet weak var singUpPassTextField: UITextField!
  @IBOutlet weak var singUpSubmitButton: UIButton!
  @IBOutlet var viewStackViews: UIView!
  var arrayStackViews: [UIView] = []
  
  private enum Constants {
    static let segmentedControlHeight: CGFloat = 40
    static let underlineViewColor: UIColor = .systemIndigo
    static let underlineViewHeight: CGFloat = 4
  }
  
  private lazy var segmentedControlContainerView: UIView = {
    let containerView = UIView()
    containerView.backgroundColor = UIColor.clear
    containerView.tintColor = UIColor.clear
    containerView.translatesAutoresizingMaskIntoConstraints = false
    return containerView
  }()
  
  private lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    
    segmentedControl.backgroundColor = UIColor.clear
    segmentedControl.tintColor = UIColor.clear
    segmentedControl.selectedSegmentTintColor = UIColor.clear

    segmentedControl.insertSegment(withTitle: "Sign Up", at: 0, animated: true)
    segmentedControl.insertSegment(withTitle: "Sign In", at: 1, animated: true)
    
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.setTitleTextAttributes([
                                              NSAttributedString.Key.foregroundColor: UIColor.gray,
                                              NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)], for: .normal)
    segmentedControl.setTitleTextAttributes([
                                              NSAttributedString.Key.foregroundColor: UIColor.black,
                                              NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)], for: .selected)
    
    segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()
  
  private lazy var bottomUnderlineView: UIView = {
    let underlineView = UIView()
    underlineView.backgroundColor = Constants.underlineViewColor
    underlineView.translatesAutoresizingMaskIntoConstraints = false
    return underlineView
  }()
  
  private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
    return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(segmentedControlContainerView)
    segmentedControlContainerView.addSubview(segmentedControl)
    segmentedControlContainerView.addSubview(bottomUnderlineView)
    
    let safeLayoutGuide = self.view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      segmentedControlContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: singUpStackView.leadingAnchor, multiplier: -5),
      segmentedControlContainerView.bottomAnchor.constraint(equalTo: singUpStackView.topAnchor, constant: -38),
      segmentedControlContainerView.widthAnchor.constraint(equalTo: safeLayoutGuide.widthAnchor),
      segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
    ])

    NSLayoutConstraint.activate([
      bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
      bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
      leadingDistanceConstraint,
      bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / (2*CGFloat(segmentedControl.numberOfSegments)))
    ])
    
    arrayStackViews = [self.singUpStackView,self.singInStackView]
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images.jpeg")!)

    customizedTextField(layer: singInEmailTextField.layer)
    customizedTextField(layer: singInPassTextField.layer)
    customizedTextField(layer: singUpNameTextField.layer)
    customizedTextField(layer: singUpPhoneNumberTextField.layer)
    customizedTextField(layer: singUpEmailTextField.layer)
    customizedTextField(layer: singUpPassTextField.layer)

    customizedSubmitButton(layer: singInSubmitButton.layer)
    customizedSubmitButton(layer: singUpSubmitButton.layer)
  }
  
  func customizedTextField(layer: CALayer) -> Void {
    layer.masksToBounds = true
    layer.cornerRadius = 15
    layer.borderColor = UIColor.gray.cgColor
    layer.borderWidth = 1
  }

  func customizedSubmitButton(layer: CALayer) -> Void {
    layer.masksToBounds = true
    layer.cornerRadius = 15
    layer.borderColor = UIColor.blue.cgColor
    layer.borderWidth = 1
  }

  @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    changeSegmentedControlLinePosition()
    if sender == self.segmentedControl {
      let segmentIndex: Int = sender.selectedSegmentIndex
      switch segmentIndex{
      case 0:
        arrayStackViews[segmentIndex].isHidden = false
        arrayStackViews[segmentIndex+1].isHidden = true
      case 1:
        arrayStackViews[segmentIndex].isHidden = false
        arrayStackViews[segmentIndex-1].isHidden = true
      default:
        print("ERROR")
      }
    }
    print("@@@@@@@@@@@@@@@@")
  }

  private func changeSegmentedControlLinePosition() {
    let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
    let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
    let leadingDistance = segmentWidth * segmentIndex
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
      self?.leadingDistanceConstraint.constant = leadingDistance
    })
  }
  
}
