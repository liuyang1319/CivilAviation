//
//  HttpError.swift
//  LipstickMachine
//
//  Created by easyto on 2019/7/14.
//  Copyright © 2019年 easyto. All rights reserved.
//

import UIKit

class HttpError: Error {

    fileprivate var desc: String?
    
    init(_ desc: String) {
        self.desc = desc
    }
}

extension HttpError: LocalizedError {
    var errorDescription: String? {
        return self.desc ?? BaseViewModel.ERROR_DESC
    }
}
