import UIKit
import Combine

//: # Future
//:Future는 비동기적인 작업의 결과인 항목 하나를 방출하는 Publisher입니다. 생성될 때 비동기 작업을 시작하며, 완료되면 항목을 방출합니다. 단 한 번만 항목을 방출할 수 있으며, 이후 방출된 항목은 무시됩니다. 이후 다시 구독을 하더라도 처음이자 마지막으로 방출된 항목을 그대로 방출합니다.

var cancellable = Set<AnyCancellable>()

func fetchData() -> Future<String, Never> {
    return Future<String, Never> { promise in
        // 비동기 작업 수행
        DispatchQueue.global().async {
            // 데이터 가져오기 시뮬레이션
            let result = "Data fetched successfully"
            
            // 작업 완료 후 항목 전달
            promise(.success(result))
            // promise(.sucess(result))
        }
    }
}

fetchData()
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

