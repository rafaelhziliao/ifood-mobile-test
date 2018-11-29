//
//  TimeLineWorker.swift
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

class TimeLineWorker {
    var service: TWTRAPIClient!
    
    init() {
      service = TWTRAPIClient()
    }
    
    func fetchUserTweets(request: TimeLine.Tweets.Request,
                         success: @escaping (TWTRTimelineDataSource) -> (),
                         failure: @escaping () -> ()?){
        
        var dataSource: TWTRUserTimelineDataSource? = nil

        dataSource =   TWTRUserTimelineDataSource(screenName: request.user,
                                                  userID: nil,
                                                  apiClient: service,
                                                  maxTweetsPerRequest: 20,
                                                  includeReplies: false,
                                                  includeRetweets: false)
        
        if dataSource != nil {
            success(dataSource!)
        } else {
            failure()
        }
      
    }
}