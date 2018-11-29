//
//  TimeLinePresenter.swift
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

protocol TimeLinePresentationLogic {
    func presentFetchedTweets(response: TimeLine.Tweets.Response)
    func presentFetchTweetsFailure()
}

class TimeLinePresenter: TimeLinePresentationLogic {
    weak var viewController: TimeLineDisplayLogic?
  
    // MARK: Presentation
  
    func presentFetchedTweets(response: TimeLine.Tweets.Response) {
        let viewModel = TimeLine.Tweets.ViewModel(fetchedTweets: response.tweetsDataSource)
        viewController?.displayTweets(viewModel: viewModel)
    }
    
    func presentFetchTweetsFailure() {
        
    }
}