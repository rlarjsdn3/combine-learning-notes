import UIKit
import Combine

//: # Sink
//: Sink는 구독을 하자마자 항목을 무한정 전달받는 가장 간단한 Subscriber입니다.

var subscriptions = Set<AnyCancellable>()

Array(1...7).publisher
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &subscriptions)

//: Cancellable 프로토콜에 구현되어 있는 `cancel()` 메서드를 호출하면 구독이 중단됩니다.

let subject = PassthroughSubject<Int, Never>()
let cancellable = subject
    .sink { value in
        print(value)
    }
subject.send(8)
subject.send(9)
subject.send(10)

cancellable.cancel()
subject.send(11)

//: RxSwift와 유사한 개념: Subsribe
