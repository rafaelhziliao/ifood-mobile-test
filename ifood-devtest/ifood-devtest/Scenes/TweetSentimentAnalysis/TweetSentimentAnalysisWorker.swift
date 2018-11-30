//
//  TweetSentimentAnalysisWorker.swift
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

protocol TweetSentimentAnalysisService {
    func requestSentimentAnalysisTweet(tweet: String,
                                        success: @escaping (Sentiment) -> (),
                                        failure: @escaping (Error) -> ())

}


class TweetSentimentAnalysisWorker {
    var service: TweetSentimentAnalysisService!
    
    init(service: TweetSentimentAnalysisService) {
        self.service = service
    }
    
    func doSomeWork() {
    }
    
    func requestSentimentAnalysisTweet(request: TweetSentimentAnalysis.SentimentAnalyzed.Request,
                                       success: @escaping (Sentiment) -> (),
                                       failure: @escaping (Error) -> () = {_ in }) {
        
        service.requestSentimentAnalysisTweet(tweet: request.tweet, success: { (sentiment) in
            success(sentiment)
        }){ (error) in
            failure(error)
        }
    }
    
}
