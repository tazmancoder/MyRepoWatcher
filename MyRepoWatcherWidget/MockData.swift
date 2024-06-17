//
//  MockData.swift
//  MyRepoWatcherWidgetExtension
//
//  Created by Mark Perryman on 6/17/24.
//

import Foundation

struct MockData {
	static let repoOne = Repository(
		name: "Repository 1",
		owner: Owner(avatarUrl: ""),
		hasIssues: false,
		forks: 176,
		watchers: 978,
		openIssues: 122,
		pushedAt: "2024-01-22T13:31:48Z", avatarData: Data(),
		contributors: [
			Contributor(login: "Mark Perryman", avatarUrl: "", contributions: 600, avatarData: Data()),
			Contributor(login: "Kristine Perryman", avatarUrl: "", contributions: 190, avatarData: Data()),
			Contributor(login: "Jerry Keough", avatarUrl: "", contributions: 230, avatarData: Data()),
			Contributor(login: "Steve Chamberlin", avatarUrl: "", contributions: 100, avatarData: Data()),
			Contributor(login: "Devon Perryman", avatarUrl: "", contributions: 170, avatarData: Data()),
			Contributor(login: "Cheyenne Larabee", avatarUrl: "", contributions: 127, avatarData: Data()),
		]
	)
	
	static let repoOneV2 = Repository(
		name: "Repository 1",
		owner: Owner(avatarUrl: ""),
		hasIssues: false,
		forks: 306,
		watchers: 1978,
		openIssues: 252,
		pushedAt: "2024-05-22T13:31:48Z", avatarData: Data(),
		contributors: [
			Contributor(login: "Mark Perryman", avatarUrl: "", contributions: 764, avatarData: Data()),
			Contributor(login: "Kristine Perryman", avatarUrl: "", contributions: 492, avatarData: Data()),
			Contributor(login: "Jerry Keough", avatarUrl: "", contributions: 453, avatarData: Data()),
			Contributor(login: "Steve Chamberlin", avatarUrl: "", contributions: 145, avatarData: Data()),
			Contributor(login: "Devon Perryman", avatarUrl: "", contributions: 324, avatarData: Data()),
			Contributor(login: "Cheyenne Larabee", avatarUrl: "", contributions: 327, avatarData: Data()),
		]
	)
	
	static let repoTwo = Repository(
		name: "Repository 2",
		owner: Owner(avatarUrl: ""),
		hasIssues: true,
		forks: 56,
		watchers: 129,
		openIssues: 57,
		pushedAt: "2024-05-22T13:31:48Z", avatarData: Data()
	)
}
