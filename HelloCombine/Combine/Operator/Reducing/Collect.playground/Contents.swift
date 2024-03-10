import UIKit
import Combine

//: # Collect
//: 업스트림 `Publisher`가 방출하는 모든 항목을 받아 하나의 배열로 만든 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

// ① 단순히 항목을 합치는 방법
[1, 2, 3, 4, 5].publisher
    .collect()
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② 최대 개수를 지정해 항목을 합치는 방법
Array(1...100).publisher
    .collect(9)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ③ 주기 시간을 지정해 항목을 합치는 방법
let mainScheduler = DispatchQueue.main
let timerPublisher = Timer.publish(every: 0.3, on: .main, in: .default)
timerPublisher
//    .collect(.byTime(mainScheduler, .seconds(1)))
    .collect(.byTimeOrCount(mainScheduler, .seconds(1), 2))
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
timerPublisher.connect()

//: RxSwift와 유사한 개념: ToArray, Buffer
