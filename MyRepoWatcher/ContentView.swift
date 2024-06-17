//
//  ContentView.swift
//  MyRepoWatcher
//
//  Created by Mark Perryman on 6/17/24.
//

import SwiftUI

struct ContentView: View {
	@State private var newRepo = ""
	@State private var repos: [String] = []
	
	var body: some View {
		NavigationStack {
			VStack {
				HStack {
					TextField("Ex. sallen0400/swift-news", text: $newRepo)
						.autocapitalization(.none)
						.autocorrectionDisabled()
						.textFieldStyle(.roundedBorder)
					
					Button {
						withAnimation {
							if !repos.contains(newRepo) && !newRepo.isEmpty {
								repos.append(newRepo)
								UserDefaults.shared.setValue(repos, forKey: UserDefaults.repoKey)
								newRepo = ""
							} else {
								print("Repo already exist or name was empty.")
							}
						}
					} label: {
						Image(systemName: "plus.circle.fill")
							.resizable()
							.frame(width: 30, height: 30)
							.foregroundColor(.green)
					}
				}
				.padding()
				
				VStack(alignment: .leading) {
					Text("Saved Repos")
						.font(.footnote)
						.foregroundColor(.secondary)
						.padding(.leading)
					
					List(repos.sorted(), id: \.self) { repo in
						Text(repo)
							.swipeActions {
								Button("Delete") {
									withAnimation {
										if repos.count > 1 {
											repos.removeAll(where: { $0 == repo })
											UserDefaults.shared.set(repos, forKey: UserDefaults.repoKey)
										}
									}
								}
								.tint(.red)
							}
					}
				}
			}
			.navigationTitle("Repo List")
			.onAppear {
				guard let retrievedRepos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
					let defaultValues = ["delawaremathguy/ShoppingList17"]
					UserDefaults.shared.setValue(defaultValues, forKey: UserDefaults.repoKey)
					repos = defaultValues
					return
				}
				repos = retrievedRepos
			}
		}
	}
}

#Preview {
	ContentView()
}
