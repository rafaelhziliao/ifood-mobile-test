//
//  TweetSentimentAnalysisPresenter.swift
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

protocol TweetSentimentAnalysisPresentationLogic {
    func presentAnalyzedSentiment(response: TweetSentimentAnalysis.SentimentAnalyzed.Response)
    func presentAnalyzedSentimentError()
}

class TweetSentimentAnalysisPresenter: TweetSentimentAnalysisPresentationLogic {
    weak var viewController: TweetSentimentAnalysisDisplayLogic?
  
    // MARK: Presentation
  
    func presentAnalyzedSentiment(response: TweetSentimentAnalysis.SentimentAnalyzed.Response) {
        
        guard let score = response.sentimentAnalysis.documentSentiment?.score else {
            return
        }
        
        var emojiFace: String
        var viewBackGroundColor: UIColor
        var typeOfTweet: String
        
        if score > 0.0 {
            emojiFace = "😃"
            typeOfTweet = "This is a happy tweet"
            viewBackGroundColor = .yellow
        } else if score < 0.0 {
            emojiFace = "😔"
            typeOfTweet = "This is a sad tweet"
            viewBackGroundColor = .twitterVerifiedBlue
        } else {
            emojiFace = "😐"
            typeOfTweet = "This is a neutral tweet"
            viewBackGroundColor = .gray
        }

        let textAlignment = NSMutableParagraphStyle()
        textAlignment.alignment = .center
        
        let emojiAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 80),
                               NSAttributedStringKey.paragraphStyle: textAlignment]
        
        let typeOfTweetAttributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20),
                                     NSAttributedStringKey.paragraphStyle: textAlignment]
        
        let tweetAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                                     NSAttributedStringKey.paragraphStyle: textAlignment]


        let formattedText = NSMutableAttributedString(string: emojiFace, attributes: emojiAttributes)
        formattedText.append(NSMutableAttributedString(string: "\n\n\n\(typeOfTweet)", attributes: typeOfTweetAttributes))
        formattedText.append(NSMutableAttributedString(string: "\n\n\(response.tweet)", attributes: tweetAttributes))
        
        let viewModel = TweetSentimentAnalysis.SentimentAnalyzed.ViewModel(sentimentAnalyzed: formattedText, viewBackgroundColor: viewBackGroundColor)
        
        viewController?.displayAnalyzedSentiment(viewModel: viewModel)
    }
    
    func presentAnalyzedSentimentError() {
        
    }
}
