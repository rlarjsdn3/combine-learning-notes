import UIKit
import Combine

//: # CurrentValueSubject
//: CurrentValueSubject는 값 하나를 가지며, 값이 바뀔 때마다 항목을 방출하는 Subject입니다. PassthroughSubject와 다르게, 가장 최근에 방출된 하나의 값을 버퍼에 유지합니다. 새로운 Subscriber가 해당 Subject를 구독하면 해당 Subscriber는 버퍼에 유지된 항목 하나를 곧바로 전달받습니다. `send(_:)` 메서드를 호출하거나, `value` 프로퍼티에 새로운 값을 대입함으로써 값을 업데이트할 수 있습니다.

var cancellable = Set<AnyCancellable>()

let subject = CurrentValueSubject<String, Never>("✏️")
subject
    .sink { value in
        print("1st: \(value)")
    }

subject.send("⭐️")

subject
    .sink { value in
        print("2nd: \(value)")
    }

subject.value = "🛠️"
subject.send(completion: .finished)

//: RxSwift와 유사한 개념: BehaviorSubject
