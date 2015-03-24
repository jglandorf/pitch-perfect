//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Joe Glandorf (jglandorf@gmail.com) on 3/22/15.
//  Copyright (c) 2015 Mentis Avis. All rights reserved.
//  Portions from https://www.udacity.com/course/nd003 Copyright (c) 2014, 2015 Udacity
//

import Foundation

// Helper structure for recorded audio
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!     // path to file
    var title: String!          // recording title
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
