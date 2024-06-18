//
//  NetworkManager.swift
//  MyRepoWatcher
//
//  Created by Mark Perryman on 6/17/24.
//

import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	let decoder = JSONDecoder()
	
	private init() {
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}
	
	
	/// Performs a network call to get information about a GitHub repository
	///
	/// - Parameter urlString: Valid Web URL
	/// - Returns: A Repository Object
	func getRepo(atUrl urlString: String) async throws -> Repository {
		// Checks to make sure the url passed in is valid
		guard let url = URL(string: urlString) else {
			throw NetworkError.invalidURL
		}
		
		// Goes out and retrieves the data and response
		let (data, response) = try await URLSession.shared.data(from: url)
		
		// Checks to make sure we get back a valid response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		// Decodes the data we got back
		do {
			let codingData = try decoder.decode(Repository.CodingData.self, from: data)
			return codingData.repo
		} catch {
			throw NetworkError.invalidRepoData
		}
	}
	
	/// Performs a network call to get information about a GitHub repositories
	/// list of contributors
	///
	/// - Parameter urlString: Valid Web URL
	/// - Returns: A Repository Object
	func getContributors(atUrl urlString: String) async throws -> [Contributor] {
		// Checks to make sure the url passed in is valid
		guard let url = URL(string: urlString) else {
			throw NetworkError.invalidURL
		}
		
		// Goes out and retrieves the data and response
		let (data, response) = try await URLSession.shared.data(from: url)
		
		// Checks to make sure we get back a valid response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		// Decodes the data we got back
		do {
			let codingData = try decoder.decode([Contributor.CodingData].self, from: data)
			return codingData.map { $0.contributor }
		} catch {
			throw NetworkError.invalidRepoData
		}
	}
	
	/// Fetches and gets the Avatar image data to display to the end user
	/// - Parameter urlString: Valid URL
	/// - Returns: Image Data
	func downloadImageData(from urlString: String) async -> Data? {
		// Checks to see if URL is correct
		guard let url = URL(string: urlString) else { return nil }
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			return data
		} catch {
			return nil
		}
	}
}

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case invalidRepoData
}

enum RepoURL {
	static let prefix = "https://api.github.com/repos/"
	static let policies = "https://api.github.com/repos/tazmancoder/Policies"
	static let appAlert = "https://api.github.com/repos/tazmancoder/AppAlert"
	static let faq = "https://api.github.com/repos/tazmancoder/FAQ"
	static let deviceKit = "https://api.github.com/repos/devicekit/DeviceKit"
	static let publish = "https://api.github.com/repos/johnsundell/publish"
}

