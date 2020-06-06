//
//  EORequestionFactory.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

enum EOApi: String {
    case home = ""
}


class EORequestionFactory: NSObject {
 
        fileprivate func homeRequest(courseId:UInt64) -> EORequest {
            let request = EORequest.newEoRequest(urlString: .home,parameters: ["":courseId])
            
            return request
        }
}
