//
//  ContributorMediumView.swift
//  MyRepoWatcherWidgetExtension
//
//  Created by Mark Perryman on 6/17/24.
//

import SwiftUI
import WidgetKit

struct ContributorMediumView: View {
	let repo: Repository
	
	var body: some View {
		VStack {
			HStack {
				Text("Top Contributors")
					.font(.caption.bold())
					.foregroundStyle(.secondary)
				Spacer()
			}
			
			LazyVGrid(
				columns: Array(repeating: GridItem(.flexible()), count: 2),
				alignment: .leading,
				spacing: 20
			) {
				ForEach(repo.contributors) { contributor in
					HStack {
						Image(uiImage: UIImage(data: contributor.avatarData) ?? UIImage(resource: .avatar))
							.resizable()
							.frame(width: 44, height: 44)
							.clipShape(Circle())
						
						VStack(alignment: .leading) {
							Text(contributor.login)
								.font(.caption)
								.minimumScaleFactor(0.7)
							Text("\(contributor.contributions)")
								.font(.caption2)
								.foregroundStyle(.secondary)
								.id(contributor.id)
								.transition(.push(from: .trailing))
								.animation(.bouncy, value: contributor.id)
						}
					}
				}
			}
			
			if repo.contributors.count < 6 {
				Spacer()
			}
		}
	}
}

#Preview(as: .systemLarge) {
	SingleRepoWidget()
} timeline: {
	SingleRepoEntry(date: .now, repo: MockData.repoOne)
	SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}

