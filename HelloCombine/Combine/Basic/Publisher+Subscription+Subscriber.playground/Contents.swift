import UIKit
import Combine

//: # Publisher
//: `Publisher`는 시간의 흐름에 따라 하나 혹은 그 이상의 `Subscrbier`에 일련의 항목을 방출하게 하는 프로토콜입니다. `Publisher`의 Output과 Failure 연관된 타입(Associated Type)은 `Subscriber`의 Input와 Failure 연관된 타입과 동일해야 합니다.

//: # Subscription
//: `Subscription`은 `Publisher`와 `Subscriber` 간의 연결을 나타내는 프로토콜입니다. 값이 든 항목이나, Completion 항목을 Subscriber에게 방출하게 하고, 구독을 취소(Cancel)해 연결을 끊을 수 있습니다.

//: `Subscription`은 클래스로 정의되어야 합니다. 왜냐하면 `Subsription`은 특정 `Subscriber`가 `Publisher`를 구독할 때 정의되는 고유 식별자(identity)를 가지기 때문입니다. `Subscription`을 취소(Cancel)하는 건 `Subscriber`가 구독을 함으로써 할당된 자원을 해제하는 작업으로, 단 한 번만 취소해야 하며, 쓰레드에 안전(Thread-Safe)해야 합니다.

//: # Subscriber
//: `Subscriber`는 `Publisher`가 방출하는 항목을 전달받는 프로토콜입니다. `Publisher`의 Output과 Failure 연관된 타입(Associated Type)은 `Subscriber`의 Input와 Failure 연관된 타입과 동일해야 합니다.

//: `Subsciber`가 `Publisher`를 구독하게 하려면 `Publisher`의 `subscribe(_:)` 메서드를 호출해야 합니다. 성공적으로 구독을 하게 되면 `Publisher`는 `Subscriber`의 `receive(subscription:)` 메서드를 호출합니다. 그러면 `Subscriber`에게 `Publisher`가 방출하는 항목을 요청할 수 있게 하고, 구독을 취소하게 해주는 `Subscription` 객체를 넘겨주어 `Subscriber`가 `Publisher`에게 항목을 요청할 수 있게 합니다.
 
//: 아래 예제는 직접 `Publisher`, `Subscription`과 `Subscriber`를 정의해 사용하는 방법을 보여줍니다.

enum CombineError: Error {
    case null
}

final class CountPublisher: Publisher {
    public typealias Output = Int // 방출하는 항목의 타입은 Int
    public typealias Failure = CombineError // 방출하는 에러의 타입은 CombineError
    
    private let count: Int
    
    public init(count: Int) {
        self.count = count
    }
    
    // Subscriber를 받아들이기 위한 메서드 (필수 구현)
    public func receive<S>(subscriber: S) where S: Subscriber, CombineError == S.Failure, Int == S.Input {
        let subscription = CountSubscription(subscriber: subscriber, count: count)
        subscriber.receive(subscription: subscription)
    }
}

final class CountSubscription<S>: Subscription where S: Subscriber, S.Input == Int {
    
    private var subscriber: S? // 연결된 Subscriber
    private var count: Int
    
    init(subscriber: S?, count: Int) {
        self.subscriber = subscriber
        self.count = count
    }
    
    // Publisher에게 항목을 요쳥해 Subscriber에게 전달하는 메서드 (필수 구현)
    public func request(_ demand: Subscribers.Demand) {
        guard let subscriber = subscriber else { return }
        
        for num in 0...count {
            subscriber.receive(num) // 값이 든 항목을 방출
        }
        
        subscriber.receive(completion: .finished) // Completion 항목을 방출
    }
    
    // Publisher와 Subscriber 간 연결을 끊는 메서드 (필수 구현)
    public func cancel() {
        subscriber = nil
    }
    
}

final class CountSubscriber: Subscriber {
    typealias Input = Int // 전달받는 항목의 타입은 Int
    typealias Failure = CombineError // 전달받는 에러의 타입은 CombineError
    
    // Subscriber가 구독에 성공하면 호출되는 메서드 (필수 구현)
    // Subscriber가 Publisher에게 항목을 최초로 요청하거나, 방출을 취소할 수 있습니다.
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
        // .unlimited: 항목을 무한정 받음
        // .max(_): 항목을 최대 N개까지 받음
        // .none: 항목을 더 요청하지 않음
        // ⭐️ 항목은 누적되어 요청됩니다.
    }
    
    // Subscriber가 Publisher로부터 항목을 전달받으면 호출되는 메서드 (필수 구현)
    // Subscriber가 Publisher에게 항목을 추가로 요청하거나, 하지 않을 수 있습니다.
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received Input: \(input)")
        return .none
    }
    
    // Subscriber가 Publisher로부터 Completion 혹은 Error 항목을 전달받으면 호출되는 메서드 (필수 구현)
    func receive(completion: Subscribers.Completion<CombineError>) {
        print("Received Completion: \(completion)")
    }
}

var cancellable = Set<AnyCancellable>()

let countPublisher = CountPublisher(count: 9)
countPublisher
    .subscribe(CountSubscriber())
