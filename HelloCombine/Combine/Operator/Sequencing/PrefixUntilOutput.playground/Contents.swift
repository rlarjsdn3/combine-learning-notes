import UIKit
import Combine

//: # PrefixUntilOutput
//: 업스트림 `Publisher`가 방출하는 항목을 트리거 `Publisher`가 항목을 방출할 때까지 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let upstream = PassthroughSubject<Int, Never>()
let trigger = PassthroughSubject<Int, Never>()

upstream
    .prefix(untilOutputFrom: trigger)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

upstream.send(10)
upstream.send(20)

trigger.send(777)
upstream.send(30)
upstream.send(40)

upstream.send(completion: .finished)

