//
//  EOFileSystem.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOFileSystem: NSObject {
    class func appDocumentDirectoryPath() -> String {
        let document = Path.documents
        return document.string
    }
}
