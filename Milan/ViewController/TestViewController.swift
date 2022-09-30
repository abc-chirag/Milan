//
//  TestViewController.swift
//  Milan
//
//  Created by mac on 12/11/21.
//

import UIKit

class TestViewController: UIViewController {

    let utiltiy = HttpUtility.shared

    override func viewDidLoad() {
        super.viewDidLoad()
//        getApi()
//        postApi()
        putApi()
    }


    func getApi() {

        let requestUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let request = HURequest(withUrl: requestUrl!, forHttpMethod: .get)

        self.utiltiy.request(huRequest: request, resultType: GetModel.self) { (response) in
            switch response
            {
            case .success(let employee):
                print(employee!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    func postApi() {

        let requestUrl = URL(string: "https://reqres.in/api/users")
        let registerUserRequest = PostRequestModel(name: "Milan", job: "Savaliya")

        let registerUserBody = try! JSONEncoder().encode(registerUserRequest)
        let request = HURequest(withUrl: requestUrl!, forHttpMethod: .post, requestBody: registerUserBody)

        self.utiltiy.request(huRequest: request, resultType: PostModel.self) { (response) in
            switch response
            {
            case .success(let registerResponse):
                print(registerResponse!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }


    func putApi() {
        let requestUrl = URL(string: "https://reqres.in/api/users/2")
        let registerUserRequest = PostRequestModel(name: "Milan", job: "Savaliya")

        let registerUserBody = try! JSONEncoder().encode(registerUserRequest)
        let request = HURequest(withUrl: requestUrl!, forHttpMethod: .put, requestBody: registerUserBody)

        self.utiltiy.request(huRequest: request, resultType: PutModel.self) { (response) in
            switch response
            {
            case .success(let registerResponse):
                print(registerResponse!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

// MARK: - GetModel
struct GetModel : Codable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}

// MARK: - PostModel
struct PostRequestModel: Codable {
    let name : String?
    let job : String?

    init(name: String, job: String) {
        self.name = name
        self.job = job
    }
}

struct PostModel : Codable {
    let name : String?
    let job : String?
    let id : String?
    let createdAt : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case job = "job"
        case id = "id"
        case createdAt = "createdAt"
    }
}

struct PutModel : Codable {
    let name : String?
    let job : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case job = "job"
        case updatedAt = "updatedAt"
    }
}
