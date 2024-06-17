//
//  SingleRepoWidget.swift
//  MyRepoWatcherWidgetExtension
//
//  Created by Mark Perryman on 6/17/24.
//

import SwiftUI
import WidgetKit

struct SingleRepoProvider: TimelineProvider {
	func placeholder(in context: Context) -> SingleRepoEntry {
		SingleRepoEntry(date: .now, repo: MockData.repoOne)
	}
	
	func getSnapshot(in context: Context, completion: @escaping (SingleRepoEntry) -> Void) {
		let entry = SingleRepoEntry(date: .now, repo: MockData.repoTwo)
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<SingleRepoEntry>) -> Void) {
		Task {
			let nextUpdate = Date().addingTimeInterval(43200) // This is 12 hours in seconds
			
			do {
				// Get Repo
				let repoToShow = RepoURL.faq
				var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
				let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
				repo.avatarData = avatarImageData ?? Data()
				
				if context.family == .systemLarge {
					// Get Contributors
					let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + "/contributors")
					var topSix = Array(contributors.prefix(6))
					
					// Download top 6 avatars
					for i in topSix.indices {
						let avatarData = await NetworkManager.shared.downloadImageData(from: topSix[i].avatarUrl)
						topSix[i].avatarData = avatarData ?? Data()
					}
					
					// Attach the contributors to the repo
					repo.contributors = topSix
				}
				
				// Create Entry & Timeline
				let entry = SingleRepoEntry(date: .now, repo: repo)
				let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
				completion(timeline)
			} catch {
				print("❌ Error: \(error.localizedDescription)")
			}
			
		}
	}
}

struct SingleRepoEntry: TimelineEntry {
	var date: Date
	let repo: Repository
}

struct SingleRepoEntryView: View {
	@Environment(\.widgetFamily) var family
	
	var entry: SingleRepoEntry
	
	var body: some View {
		switch family {
		case .systemMedium:
			RepoMediumView(repo: entry.repo)
				.padding(.bottom, 20)
		case .systemLarge:
			VStack {
				RepoMediumView(repo: entry.repo)
					.padding(.bottom, 20)
				
				ContributorMediumView(repo: entry.repo)
			}
		case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
			EmptyView()
		@unknown default:
			EmptyView()
		}
	}
}

struct SingleRepoWidget: Widget {
	let kind: String = "SingleRepoWidget"
	
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: SingleRepoProvider()) { entry in
			if #available(iOS 17.0, *) {
				SingleRepoEntryView(entry: entry)
					.containerBackground(.fill.tertiary, for: .widget)
			} else {
				SingleRepoEntryView(entry: entry)
					.padding()
					.background()
			}
		}
		.configurationDisplayName("SingleRepo")
		.description("Track a single repository.")
		.supportedFamilies([.systemMedium, .systemLarge])
	}
}

#Preview(as: .systemMedium) {
	SingleRepoWidget()
} timeline: {
	SingleRepoEntry(date: .now, repo: MockData.repoOne)
	SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}
