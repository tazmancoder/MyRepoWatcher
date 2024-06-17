//
//  RepoMediumView.swift
//  MyRepoWatcherWidgetExtension
//
//  Created by Mark Perryman on 6/17/24.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
	let repo: Repository
	let formatter = ISO8601DateFormatter()
	
	var numberOfDaysSince: Int {
		calculateDaysSinceLastActivity(from: repo.pushedAt)
	}
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				HStack {
					Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(resource: .avatar))
						.resizable()
						.frame(width: 50, height: 50)
						.clipShape(Circle())
					
					Text(repo.name)
						.font(.title2)
						.fontWeight(.semibold)
						.minimumScaleFactor(0.6)
						.lineLimit(1)
				}
				.padding(.bottom, 6)
				
				HStack {
					StatLabel(value: repo.watchers, systemImageName: "star.fill")
					StatLabel(value: repo.forks, systemImageName: "tuningfork")
					if repo.hasIssues {
						StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
					}
				}
			}
			
			Spacer()
			
			VStack {
				Text("\(numberOfDaysSince)")
					.font(.system(size: 50))
					.frame(width: 90)
					.minimumScaleFactor(0.6)
					.lineLimit(1)
					.foregroundColor(numberOfDaysSince > 50 ? .pink : .green)
					.contentTransition(.numericText(countsDown: true))
				
				Text("days ago")
					.font(.caption2)
					.foregroundStyle(.secondary)
			}
		}
		.containerBackground(for: .widget, content: { })
	}
	
	func calculateDaysSinceLastActivity(from dateString: String) -> Int {
		let formatter = ISO8601DateFormatter()
		let lastActivityDate = formatter.date(from: dateString) ?? .now
		let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
		
		return daysSinceLastActivity
	}
	
}

#Preview(as: .systemLarge) {
	DoubleRepoWidget()
} timeline: {
	DoubleRepoEntry(date: .now, topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
}

fileprivate struct StatLabel: View {
	let value: Int
	let systemImageName: String
	
	var body: some View {
		Label(
			title: {
				Text("\(value)")
					.font(.footnote)
					.contentTransition(.numericText(countsDown: true))
			},
			icon: {
				Image(systemName: systemImageName)
					.foregroundColor(.green)
			}
		)
		.fontWeight(.medium)
	}
}

