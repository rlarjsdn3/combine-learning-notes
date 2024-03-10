import UIKit
import Combine

//: # Share
//: 업스트림 `Publisher`가 다수의 `Subscriber`에게 항목을 방출하게 (스트림을 공유)하기 위해 `Subject`를 제공하는 Publisher입니다. (Publisher는 Unicast, Subject는 Multicast로 작동합니다) Multicast Publisher와 PassthroughSubject를 결합한 형태이고, 암시적으로 autoconnect() 메서드를 호출합니다.

var cancellable = Set<AnyCancellable>()

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

let url = URL(string: "https://jsonplaceholder.typicode.com/users/1/posts")!
let postsPublisher = URLSession.shared.dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())
    .replaceError(with: [])
    .share()

postsPublisher
    .sink { value in
        print("Stream 1 Received: \(value)")
    }
    .store(in: &cancellable)
postsPublisher
    .sink { value in
        print("Stream 2 Received: \(value)")
    }
    .store(in: &cancellable)

//: RxSwift와 유사한 개념: Publish, Replay, RefCount, Share
