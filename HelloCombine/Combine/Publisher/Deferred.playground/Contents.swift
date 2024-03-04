import UIKit
import Combine

//: # Deferred
//: Deferred는 실제로 항목을 방출할 때까지(Subscriber가 구독할 때까지) 실제 Publisher를 만들지 않습니다. 새로운 Subscriber가 구독이 되면 새로운 Subscriber를 위한 Publisher를 만듭니다. (lazy 키워드와 비슷)

var cancellable = Set<AnyCancellable>()

let deferred = Deferred {
    return Future<String, Never> { promise in
        DispatchQueue.global().async {
            let now = Date.now
            let string = now.formatted(
                Date.FormatStyle()
                    .hour(.twoDigits(amPM: .wide))
                    .minute(.twoDigits)
                    .second(.twoDigits)
            ).description
            promise(.success(string))
        }
    }
}

deferred
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

Thread.sleep(forTimeInterval: 3)

deferred
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

