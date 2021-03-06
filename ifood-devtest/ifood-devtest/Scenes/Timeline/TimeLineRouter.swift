//
//  TimeLineRouter.swift
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

@objc protocol TimeLineRoutingLogic {
    func routeToSentimentAnalysis()
}

protocol TimeLineDataPassing {
    var dataStore: TimeLineDataStore? { get }
}

class TimeLineRouter: NSObject, TimeLineRoutingLogic, TimeLineDataPassing {
    weak var viewController: TimeLineViewController?
    var dataStore: TimeLineDataStore?
  
    // MARK: Routing
  
    func routeToSentimentAnalysis() {
        let destinationVC = TweetSentimentAnalysisViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSentimentAnalysis(source: dataStore!, destination: &destinationDS)
        navigateToSentimentAnalysis(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
  
    func navigateToSentimentAnalysis(source: TimeLineViewController, destination: TweetSentimentAnalysisViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
  
    // MARK: Passing data
  
    func passDataToSentimentAnalysis(source: TimeLineDataStore, destination: inout TweetSentimentAnalysisDataStore) {
        destination.tweet = source.tweet
    }
}
