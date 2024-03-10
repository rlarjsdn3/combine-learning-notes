import UIKit
import Combine

//: Map
//: 업스트림 `Publisher`가 방출하는 모든 항목을 주어진 클로저가 반환하는 값으로 변환하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

// ① 일반적인 코드
Record(output: [1, 2, 3, 4, 5], completion: .finished)
    .map { value -> Double in
        return pow(value, 2)
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② KeyPath를 이용한 코드
struct Size {
    var width: Double
    var height: Double
}

let subject = PassthroughSubject<Size, Never>()
subject
    .map(\.width, \.height)
    .sink { width, height in
        print(width, height)
    }
    .store(in: &cancellable)

subject.send(.init(width: 250, height: 250))
subject.send(.init(width: 500, height: 100))

//: RxSwift와 유사한 개념: Map
