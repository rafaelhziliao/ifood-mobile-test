//
//  TimeLineViewController.swift
//  ifood-devtest
//
//  Created by Rafael Zilião on 28/11/18.
//  Copyright (c) 2018 Rafael Zilião. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import TwitterKit

protocol TimeLineDisplayLogic: class {
    func displayTweets(viewModel: TimeLine.Tweets.ViewModel)
}

class TimeLineViewController: TWTRTimelineViewController, TimeLineDisplayLogic {
    var interactor: TimeLineBusinessLogic?
    var router: (NSObjectProtocol & TimeLineRoutingLogic & TimeLineDataPassing)?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e.g. 'neiltyson'"
        searchController.searchBar.text = "neiltyson"
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .blue
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }

        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        return searchController
        
    }()
   
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = TimeLineInteractor()
        let presenter = TimeLinePresenter()
        let router = TimeLineRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTwitterKitDelegates() {
        self.tweetViewDelegate = self
        self.timelineDelegate = self
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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

        setup()
        setupTwitterKitDelegates()
        setupUI()
        fetchTweets()
    }
  
    // MARK: Fetch data
    
    private func fetchTweets() {
        let request = TimeLine.Tweets.Request(user: searchController.searchBar.text ?? "neiltyson")
        interactor?.fetchUserTweets(request: request)
    }
    
    // MARK: Display methods
    
    func displayTweets(viewModel: TimeLine.Tweets.ViewModel) {
        dataSource = viewModel.fetchedTweets
    }
}


extension TimeLineViewController: TWTRTweetViewDelegate {
    
    func tweetView(tweetView: TWTRTweetView, didSelectTweet tweet: TWTRTweet) {
        router?.routeToSentimentAnalysis()
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap url: URL) {
        router?.routeToSentimentAnalysis()
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap tweet: TWTRTweet) {
        router?.routeToSentimentAnalysis()
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap image: UIImage, with imageURL: URL) {
        router?.routeToSentimentAnalysis()
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTapVideoWith videoURL: URL) {
        router?.routeToSentimentAnalysis()
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTapProfileImageFor user: TWTRUser) {
        router?.routeToSentimentAnalysis()
    }
    
}

extension TimeLineViewController: TWTRTimelineDelegate {
    
}

extension TimeLineViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
