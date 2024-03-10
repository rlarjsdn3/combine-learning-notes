import UIKit
import Combine

//: # Multicast
//: 업스트림 `Publisher`가 다수의 `Subscriber`에게 항목을 방출하게 (스트림을 공유)하기 위해 `Subject`를 제공하는 Publisher입니다. (Publisher는 Unicast, Subject는 Multicast로 작동합니다)

var cancellable = Set<AnyCancellable>()

// - 스트림을 공유하지 않으면
let numbersPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9].publisher
    .print("Number")

numbersPublisher
    .sink { value in
        print("Stream 1 recevied: \(value)")
    }
    .store(in: &cancellable)
numbersPublisher
    .sink { value in
        print("Stream 2 recevied: \(value)")
    }
    .store(in: &cancellable)

print("---------------------------------------", terminator: "\n\n")

// ① 모든 Subscriber가 주어진 Subject를 공유하는 Publisher를 생성하는 방법
let multicast1Publisher = numbersPublisher
    .multicast(subject: PassthroughSubject<Int, Never>()) // ②의 방법과 차이가 뭘까?

multicast1Publisher
    .sink { value in
        print("Stream 1 recevied: \(value)")
    }
    .store(in: &cancellable)
multicast1Publisher
    .sink { value in
        print("Stream 2 recevied: \(value)")
    }
    .store(in: &cancellable)
multicast1Publisher.connect()

print("---------------------------------------", terminator: "\n\n")

// In contrast with ``Publisher/multicast(_:)``, this method produces a publisher that shares the provided ``Subject`` among all the downstream subscribers.



// ② 각 Subscriber를 위한 개별 Subject를 만들어 Publisher를 생성하는 방법
let multicast2Publisher = numbersPublisher
    .multicast { PassthroughSubject<Int, Never>() } // ①의 방법과 차이가 뭘까?

multicast2Publisher
    .sink { value in
        print("Stream 1 recevied: \(value)")
    }
    .store(in: &cancellable)
multicast2Publisher
    .sink { value in
        print("Stream 2 recevied: \(value)")
    }
    .store(in: &cancellable)
multicast2Publisher.connect()

// In contrast with ``Publisher/multicast(subject:)``, this method produces a publisher that creates a separate ``Subject`` for each subscriber.


//: RxSwift와 유사한 개념: Multicast
