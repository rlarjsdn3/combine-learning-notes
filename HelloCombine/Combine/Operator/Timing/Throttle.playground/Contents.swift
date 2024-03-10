import UIKit
import Combine

//: # Throttle
//: 업스트림 `Publisher`가 항목을 방출하고 일정 시간이 경과한 후에 다음 항목을 방출할 수 있도록 하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

Timer.publish(every: 3.0, on: .main, in: .default)
    .autoconnect()
    .print("Publish at: \(Date().description)")
    .throttle(for: 10.0, scheduler: RunLoop.main, latest: true)
    .sink { value in
        print("Received Timestamp: \(value).")
    }
    .store(in: &cancellable)

// latest 매개변수가 true라면 가장 최근에 방출된 항목을 내보내고, false라면 첫 번째로 방출된 항목을 내보냅니다.

// Debounce vs. Throttle
// Debounce: 항목을 더 이상 전달받지 않으면 일정 시간이 경과한 후 마지막으로 전달받은 항목을 방출합니다.
// Throttle: 일정 시간이 경과한 후 첫 번째나 마지막으로 전달받은 항목을 방출합니다.


//: RxSwift와 유사한 개념: Throttle
