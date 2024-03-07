import UIKit
import Combine

//: # Comparison
//: 다른 `Publisher`가 방출한 새로운 항목이 이전에 방출한 항목보다 증가하는 순서에 있을 때만(비교 결과가 만족할 때만) 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

// ① 방출한 항목 중 가장 큰 값만 방출하는 방법
[5, 4, 9, 7, 3].publisher
    .max()
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② 비교 로직 직접 구현-큰 값만 방출하는 방법
struct Person {
    var name: String
    var age: Int
}

let peoplePublisher = [
    Person(name: "김문어", age: 16),
    Person(name: "김소월", age: 27),
    Person(name: "김지지", age: 5),
    Person(name: "김흰둥", age: 5),
    Person(name: "김건우", age: 20)
].publisher
peoplePublisher
    .max { person1, person2 in
        return person1.name > person2.name
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// 가장 작은 값만 방출하는 방법은 min(), min(by:) 메서드를 사용하세요.
