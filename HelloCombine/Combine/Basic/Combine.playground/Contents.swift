import UIKit
import Combine

//: # Combine
//: Combine 프레임워크는 애플에서 발표한 비동기 이벤트 처리를 위한 선언적 프레임워크입니다. 시간의 흐름에 따라 항목을 방출하는 `Publisher`와 `Publisher`로부터 이를 전달받는 `Subscriber`가 있으며, 이 둘 사이를 이어주는 `Subscription`이 존재합니다.

//: `Publisher`와 `Subsriber`의 역할을 간단하게 설명하면 아래와 같습니다.
//: * `Publisher` 프로토콜은 시간의 흐름에 따라 하나 혹은 그 이상의 `Subscrbier`에 일련의 항목을 방출할 수 있는 타입입니다. `Publisher`는 `Operators`를 가지며 업스트림 `Publisher`로부터 항목을 받아 가공해 재방출할 수 있습니다.
//: * `Publisher` 고리의 끝으로 `Subscriber`가 항목을 전달받습니다. `Publisher`는 `Subscriber`가 항목을 요청할 때만 항목을 방출합니다. 이는 `Subscriber`가 `Publisher`로부터 얼마나 많이 항목을 전달받을지 컨트롤할 수 있게 합니다.

//: Combine 프레임워크를 사용하면 비동기 코드를 깔끔하게 작성할 수 있습니다. Combine 프레임워크를 사용하지 않더라도 델리게이트 패턴, 콜백을 사용해 비동기 처리를 할 수 있지만, 코드의 깊이가 너무 깊어지고 예외 처리가 까다로워집니다. Combine 프레임워크를 이런 문제를 해결할 수 있습니다.

//: UI 인터랙션도 단순해집니다. 복잡한 Target-Action 패턴으로 이벤트를 처리할 필요가 없어지죠. 예를 들어, 텍스트 필드를 `Publisher`로 만들고, 이를 `Subscriber`가 구독해 업데이트를 감지하고, 네트워크 통신 등 적절한 로직을 수행하게 할 수 있습니다. 그리고 또 다른 `Publisher`가 (로직의 결과인) 항목을 방출해 앱을 업데이트하도록 할 수 있습니다.

//: 이렇듯, Combine 프레임워크는 중첩된 클로저와 콜백과 같은 문제 소지가 다분한 코드를 지양하고, 직관적인 코드 작성을 가능케 해주어 유지 보수를 쉽게 만들어준다는 장점이 있습니다.