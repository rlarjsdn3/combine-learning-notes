import UIKit
import Combine

//: # Concatenate
//: 업스트림 `Publisher`가 방출하는 항목 앞이나 뒤에 새로운 항목을 추가하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let arrayPublisher = [1, 2, 3, 4, 5].publisher

let appendPublisher = [6, 7, 8].publisher
let prependPublisher = [-2, -1, 0].publisher

// ① 뒤에 새로운 항목을 추가하는 방법
arrayPublisher
    .append(6, 7, 8)
//    .append([6, 7, 8])
//    .append(appendPublisher)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② 앞에 새로운 항목을 추가하는 방법
arrayPublisher
//    .prepend(-2, -1, 0)
//    .prepend([-2, -1, 0])
    .prepend(prependPublisher)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

//: RxSwift와 유사한 개념: StartWith
