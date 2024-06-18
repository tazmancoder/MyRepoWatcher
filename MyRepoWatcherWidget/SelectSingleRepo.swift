//
//  SelectSingleRepo.swift
//  MyRepoWatcher
//
//  Created by Mark Perryman on 6/17/24.
//

import Foundation
import AppIntents

struct SelectSingleRepo: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "SelectSingleRepoIntent"

    static var title: LocalizedStringResource = "Select Single Repo"
    static var description = IntentDescription("Choose a repository to watch.")

    @Parameter(title: "Repo", optionsProvider: RepoOptionsProvider())
    var repo: String?

    struct RepoOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
			guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
				throw UserDefaultsError.retrieval
			}
            // TODO: Return possible options here.
            return repos
        }
		
		func defaultResult() async -> String? {
			"sallen0400/swift-news"
		}
    }
}


