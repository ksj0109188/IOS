import Foundation
import RxSwift


/**
 * Observable의 정의 목록
 */
print("Just")
Observable<Int>.just(1) //하나의 엘레멘트만 방출하는 시퀀스를 생성(Just Operator를 통해)
    .subscribe(onNext:{ //Obervable들은 Subscribe돼야지만 동작함, Subscribe해야 그 흐름을 볼 수 있다.
        print($0)
    })
print("Of1")
Observable<Int>.of(1,2,3,4,5) //여러개 엘레멘트를 방출하는 시퀀스를 생성(of Operator를 통해)
    .subscribe(onNext : {
        print($0)
    })
print("Of2")
Observable.of([1,2,3,45]) //Observable의 타입 추론도 가능
    .subscribe(onNext : {
        print($0)
    })
print("From")
Observable.from([1,2,3,4]) //From Operator는 배열을 인자로 받고 각 요소를 하나씩 방출
    .subscribe(onNext : {
        print($0)
    })

print("------subscribe 흐름 표시------")
Observable.of(1,2,3)
    .subscribe{ //onNext이벤트를 정의 안해줘도 알아서 Next이벤트를 실행하고 완료시킴. (소스코드 실행해보셈)
        print($0)
    }

print("------subscribe 의 다른 표현식, OnNext 말고 If Let방식을 이용한 값 핸들링------")
Observable.of(1,2,3)
    .subscribe{
        if let element = $0.element{ //OnNext 정의없이 OnNext이벤트의 엘레멘트를 가져오기
            print(element)
        }
    }

print("------empty 타입추론------")
Observable.empty()
    .debug("never")
    .subscribe{
        print($0)
    }
print("------empty 타입추론 X------")
Observable<Void>.empty()
    .debug("never")
    .subscribe{
        print($0)
    }
print("------Never------") //complete 이벤트도 실행되지 않음
Observable.never()
    .debug("never") //debug를 통해 흐름을 파악할 수 있음
    .subscribe{
        print($0)
    }

print("------range------")
Observable.range(start: 1, count: 9)
    .subscribe{
        print($0)
    }

print("------dispose------")
Observable.of(1,2,3)
    .subscribe(onNext:{
        print($0)
    })
    .dispose() //구독 취소, 이벤트를 구독취소 -> Completed됨 이 예제에선 직관적이지 않지만, 이벤트를 더 이상 발생시키지 않음.(무한히 실행되는 이벤트가 있다면 종료시킬 수 있음)

print("------disposeBag------")
let disposeBag = DisposeBag()
Observable.of(1,2,3)
    .subscribe{
        print($0)
    }
//각 observable이 구독될때 disposeable들을 DisposeBag(Disposable 배열이 존재)에 즉시 담고, 종료될때 배열에 담긴 dispose들이 방출됨.
    .disposed(by: disposeBag)


print("------create1------")
Observable.create { observer -> Disposable in
    //연산자는 observer의 이벤트를 쉽게 추가하기 위해 사용됨
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("------create2------")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError) //Error이벤트 발생시 아래 코드들을 실행하지 않음, 즉 에러가 발생하면 바로 종료
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: { //onNext이벤트 발생이면
        print($0)
    },
    onError: { //onError 이벤트 발생이면
        print($0.localizedDescription)
    },
    onCompleted: { //onCompleted 이벤트 발생이면
        print("Completed")
    },
    onDisposed: {
        print("Disposed")
    })
.disposed(by: disposeBag)

/** 지금까진, Subscribe되기만 기다리는 옵저버들을 만들었음
 *  observer들을 observable팩토리를  통해 생성할 수 있음
 *   deffered operator를 통해 특정한 옵저버를 뱉을 수 있음.
 */
print("------defferred1------")
//Observable.deferred(<#T##observableFactory: () throws -> Observable<_>##() throws -> Observable<_>#>)
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("------defferred2------")
var 뒤집기:Bool = false

let factory :Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기{
        return Observable.just("☝️")
    }else{
        return Observable.just("👇")
    }
}

for _ in 0...3{
    factory.subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)
}


