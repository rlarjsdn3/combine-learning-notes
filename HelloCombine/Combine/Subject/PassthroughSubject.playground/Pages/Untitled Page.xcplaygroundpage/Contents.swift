import UIKit
import Combine

//: # PassthroughSubject
//: PassthroughSubject는 값이 바뀔 때마다 항목을 방출하는 Subject입니다. 새로운 Subscriber가 구독 이전하기 이전에 방출된 항목은 전달받지 못하고, 이후에 방출된 항목만 전달받을 수 있습니다. `send(_:)` 메서드를 호출하 값을 업데이트할 수 있습니다.

var cancellable = Set<AnyCancellable>()

let subject = PassthroughSubject<String, Never>()
subject
    .sink { value in
        print("1st: \(value)")
    }

subject.send("⭐️")

subject
    .sink { value in
        print("2nd: \(value)")
    }

subject.send("🛠️")
subject.send(completion: .finished)

//: RxSwift와 유사한 개념: PublishSubject
