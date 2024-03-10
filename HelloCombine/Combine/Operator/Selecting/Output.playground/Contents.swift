import UIKit
import Combine

//: # Output
//: 업스트림 `Publisher`가 방출하는 항목 중 특정 인덱스 혹은 범위에 해당하는 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let arrayPublisher = Array(1...100).publisher

// ① 특정 인덱스에 위치한 항목만 방출하는 방법
arrayPublisher
    .output(at: 77)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② 특정 범위에 위치한 항목만 방출하는 방법
arrayPublisher
    .output(in: 33...77)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

//: RxSwift와 유사한 개념: ElementAt
