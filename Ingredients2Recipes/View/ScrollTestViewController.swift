//
//  ScrollTestViewController.swift
//  Ingredients2Recipes
//
//  Created by Josh Flores on 3/20/24.
//
import UIKit

class ScrollTestViewController: UIViewController {

    let scrollView: TouchPassingScrollView = {
        let sv = TouchPassingScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var testButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Big Test", for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(testPrint), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(testButton)
        
        scrollViewConstraint()
        containerViewConstraint()
        buttonConstraint()
        
        scrollView.contentSize = containerView.bounds.size
    }
    
    func scrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func containerViewConstraint() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2)
        ])
    }
    
    func buttonConstraint() {
        NSLayoutConstraint.activate([
            testButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            testButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            testButton.widthAnchor.constraint(equalToConstant: 70),
            testButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func testPrint() {
        print("Pressed")
    }
}

class TouchPassingScrollView: UIScrollView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        // Allow buttons to receive touch events
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}
