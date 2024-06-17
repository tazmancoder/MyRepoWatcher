//
//  MyRepoWatcherWidgetBundle.swift
//  SingleRepoWidget
//
//  Created by Mark Perryman on 6/17/24.
//

import WidgetKit
import SwiftUI

@main
struct MyRepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        SingleRepoWidget()
		DoubleRepoWidget()
    }
}
