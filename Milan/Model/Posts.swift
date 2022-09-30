

import Foundation
struct Posts : Codable {
	let id : Int?
	let user : User?
	let images : [String]?
	let videos : [String]?
	let likes : Int?
	let comments : [String]?
	let descriptions : String?
	let hashtags : String?
	let date_time : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user = "user"
		case images = "images"
		case videos = "videos"
		case likes = "likes"
		case comments = "comments"
		case descriptions = "descriptions"
		case hashtags = "hashtags"
		case date_time = "date_time"
	}
}


struct User : Codable {
    let id : Int?
    let name : String?
    let profile : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile = "profile"
    }
}
