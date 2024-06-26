//
//  Repository.swift
//  MyRepoWatcher
//
//  Created by Mark Perryman on 6/17/24.
//

import Foundation

struct Repository {
	let name: String
	let owner: Owner
	let hasIssues: Bool
	let forks: Int
	let watchers: Int
	let openIssues: Int
	let pushedAt: String
	var avatarData: Data
	var contributors: [Contributor] = []
	
	var daysSinceLastActivity: Int {
		let formatter = ISO8601DateFormatter()
		let lastActivityDate = formatter.date(from: pushedAt) ?? .now
		let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
		
		return daysSinceLastActivity
	}
}

extension Repository {
	struct CodingData: Decodable {
		let name: String
		let owner: Owner
		let hasIssues: Bool
		let forks: Int
		let watchers: Int
		let openIssues: Int
		let pushedAt: String
		
		var repo: Repository {
			Repository(
				name: name,
				owner: owner,
				hasIssues: hasIssues,
				forks: forks,
				watchers: watchers,
				openIssues: openIssues,
				pushedAt: pushedAt,
				avatarData: Data()
			)
		}
	}
}

struct Owner: Decodable {
	let avatarUrl: String
}

