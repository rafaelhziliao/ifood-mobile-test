//
//  TweetSentimentAnalysisViewController.swift
//  ifood-devtest
//
//  Created by Rafael Zilião on 29/11/18.
//  Copyright (c) 2018 Rafael Zilião. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Lottie

protocol TweetSentimentAnalysisDisplayLogic: class {
    func displayAnalyzedSentiment(viewModel: TweetSentimentAnalysis.SentimentAnalyzed.ViewModel)
    func displaySentimentAnalysisError(viewModel: TweetSentimentAnalysis.Error.ViewModel)
}

class TweetSentimentAnalysisViewController: UIViewController, TweetSentimentAnalysisDisplayLogic {
    var interactor: TweetSentimentAnalysisBusinessLogic?
    var router: (NSObjectProtocol & TweetSentimentAnalysisRoutingLogic & TweetSentimentAnalysisDataPassing)?

    private let tweetAnalyzedTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private let animationView: LOTAnimationView = {
        let animationView = LOTAnimationView(name: "material_loading")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopAnimation = true
        animationView.animationSpeed = 1.2
        animationView.tag = 1000
        return animationView
    }()
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = TweetSentimentAnalysisInteractor()
        let presenter = TweetSentimentAnalysisPresenter()
        let router = TweetSentimentAnalysisRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tweetAnalyzedTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tweetAnalyzedTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tweetAnalyzedTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tweetAnalyzedTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tweetAnalyzedTextView)
        setupLayout()
        requestSentimentAnalysis()
    }
    
    // MARK: Requests
    
    private func requestSentimentAnalysis() {
        showLoadAnimation()
        interactor?.requestSentimentAnalysis()
    }
    
    // MARK: Display methods
  
    func displayAnalyzedSentiment(viewModel: TweetSentimentAnalysis.SentimentAnalyzed.ViewModel) {
        hideLoadAnimation()
        tweetAnalyzedTextView.attributedText = viewModel.sentimentAnalyzed.formattedText
        view.backgroundColor = viewModel.sentimentAnalyzed.backgroundColor
    }
    
    func displaySentimentAnalysisError(viewModel: TweetSentimentAnalysis.Error.ViewModel) {
        hideLoadAnimation()
        let alert = UIAlertController(title: NSLocalizedString("WARNING", comment: ""),
                                      message: NSLocalizedString("ERROR_ANALYZE_TWEET_SENTIMENT", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Load Animation
    
    private func showLoadAnimation() {
        animationView.play()
        view.addSubview(animationView)
        animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func hideLoadAnimation() {
        guard let animationView = view.viewWithTag(1000) else { return }
        animationView.removeFromSuperview()
    }
}
