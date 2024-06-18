//
//  UserDefaults+Ext.swift
//  MyRepoWatcher
//
//  Created by Mark Perryman on 6/17/24.
//

import Foundation

extension UserDefaults {
	static var shared: UserDefaults {
		UserDefaults(suiteName: "group.com.tazmancoder.MyRepoWatcher")!
	}
	
	static let repoKey = "repos"
}

enum UserDefaultsError: Error {
	case retrieval
}
