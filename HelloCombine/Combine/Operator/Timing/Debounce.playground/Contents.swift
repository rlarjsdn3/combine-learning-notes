import UIKit
import Combine

//: # Debounce
//: 업스트림 `Publisher`가 항목을 방출하고 일정 시간이 경과해도 추기로 방출하는 항목이 없다면 마지막 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let bounces: [(Int, TimeInterval)] = [
    (0, 0),
    (1, 0.25),  // 이전 인덱스와 0.25초 차이⭐️
    (2, 1),     // 이전 인덱스와 0.75초 차이
    (3, 1.25),  // 이전 인덱스와 0.25초 차이
    (4, 1.5),   // 이전 인덱스와 0.25초 차이⭐️
    (5, 2)      // 이전 인덱스와 0.5초 차이⭐️
]

let subject = PassthroughSubject<Int, Never>()
subject
    .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

for bounce in bounces {
    DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
        subject.send(bounce.0)
    }
}

// Debounce vs. Throttle
// Debounce: 항목을 더 이상 전달받지 않으면 일정 시간이 경과한 후 마지막으로 전달받은 항목을 방출합니다.
// Throttle: 일정 시간이 경과한 후 첫 번째나 마지막으로 전달받은 항목을 방출합니다.


//: RxSwift와 유사한 개념: Debounce
