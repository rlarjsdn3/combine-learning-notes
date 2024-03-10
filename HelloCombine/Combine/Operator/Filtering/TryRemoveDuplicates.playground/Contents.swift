import UIKit
import Combine

//: # TryRemoveDuplicates
//: 업스트림 `Publisher`가 이전에 방출된 항목과 동일하지 않은 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case overflow
}

struct Size {
    var width: Double
    var height: Double
}

let publisher = [
    Size(width: 250, height: 250),
    Size(width: 250, height: 500),
    Size(width: 500, height: 100),
    Size(width: 500, height: 750),
    Size(width: 750, height: 250)
].publisher
publisher
    .tryRemoveDuplicates { size1, size2 in
        let sumOfWidth = size1.width + size2.width
        if sumOfWidth > 1000 { throw CombineError.overflow }
        return size1.width == size2.width
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("Fininshed: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

//: RxSwift와 유사한 개념: DistinctUntilChanged
