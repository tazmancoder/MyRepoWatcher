//
//  DoubleRepoWidget.swift
//  MyRepoWatcherWidgetExtension
//
//  Created by Mark Perryman on 6/17/24.
//

import WidgetKit
import SwiftUI

struct DoubleRepoProvider: TimelineProvider {
	func placeholder(in context: Context) -> DoubleRepoEntry {
		DoubleRepoEntry(date: Date(), topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
	}
	
	func getSnapshot(in context: Context, completion: @escaping (DoubleRepoEntry) -> ()) {
		let entry = DoubleRepoEntry(date: Date(), topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		Task {
			let nextUpdate = Date().addingTimeInterval(43200) // This is 12 hours in seconds
			
			do {
				// Get Top Repo
				var topRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.appAlert)
				let topAvatarImageData = await NetworkManager.shared.downloadImageData(from: topRepo.owner.avatarUrl)
				topRepo.avatarData = topAvatarImageData ?? Data()
				
				// Get Bottom Repo
				var bottomRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.deviceKit)
				let bottomAvatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo.owner.avatarUrl)
				bottomRepo.avatarData = bottomAvatarImageData ?? Data()
				
				// Create Entry and Timeline
				let entry = DoubleRepoEntry(date: .now, topRepo: topRepo, bottomRepo: bottomRepo)
				
				let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
				completion(timeline)
			} catch {
				print("❌ Error: \(error.localizedDescription)")
			}
		}
	}
}

struct DoubleRepoEntry: TimelineEntry {
	let date: Date
	let topRepo: Repository
	let bottomRepo: Repository
}

struct DoubleRepoEntryView : View {
	var entry: DoubleRepoEntry
	
	var body: some View {
		VStack(spacing: 76) {
			RepoMediumView(repo: entry.topRepo)
			RepoMediumView(repo: entry.bottomRepo)
		}
	}
}

struct DoubleRepoWidget: Widget {
	let kind: String = "DoubleRepoWidget"
	
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: DoubleRepoProvider()) { entry in
			if #available(iOS 17.0, *) {
				DoubleRepoEntryView(entry: entry)
					.containerBackground(.fill.tertiary, for: .widget)
			} else {
				DoubleRepoEntryView(entry: entry)
					.padding()
					.background()
			}
		}
		.configurationDisplayName("Douple Repo")
		.description("Keep an eye on one or two online repositories.")
		.supportedFamilies([.systemLarge])
	}
}

#Preview(as: .systemLarge) {
	DoubleRepoWidget()
} timeline: {
	DoubleRepoEntry(date: .now, topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
}


