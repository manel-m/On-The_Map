//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Manel matougui on 8/9/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}


