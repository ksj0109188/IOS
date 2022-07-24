import Foundation
import RxSwift

let disposeBag = DisposeBag()
print("------publishSubject------")
let publishSubject = PublishSubject<String>()
publishSubject.onNext("1.여러분 안녕하세요?") // onNext 이벤트 발생1, 여기서 subject는 observable

let 구독자1 = publishSubject //여기서 subject는 observer
    .subscribe(onNext: {
     print("구독자1:\($0)")
    })//.disposed(by: disposeBag)

publishSubject.onNext("2.들리시나요?") // onNext 이벤트 발생1, 여기서 subject는 observable
publishSubject.on(.next("3.대답좀 해주세요")) // onNext 이벤트 발생1, 여기서 subject는 observable

구독자1.dispose()

let 구독자2 = publishSubject //여기서 subject는 observer
    .subscribe(onNext: {
        print("구독자2:\($0)")
    })//.disposed(by: disposeBag)

publishSubject.onNext("4.제발요")
//publishSubject.onCompleted()

publishSubject.onNext("5.끝났나요?")

구독자2.dispose()

publishSubject.subscribe(onNext:{
    print("Observable이 complete이후의 구독1\($0)")
}).disposed(by: disposeBag)

publishSubject.onNext("Complete 이후에도 찍힐까?")

print("------BehaviorSubject------")
enum SubjectError:Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "Behavior 서브젝트는 초기값 필수")
//behaviorSubject.subscribe{
//    print("초기값 구독",$0.element ?? $0)
//
//}.disposed(by: disposeBag)

behaviorSubject.onNext("1. 첫번째 값 시작 ")

behaviorSubject.subscribe{
    print("첫번째 구독",$0.element ?? $0)
    
}.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe{
    print("두번째 구독",$0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value() // behavior 서브젝트는 옵저버에서 발생한 데이터를 외부에 값을 전달가능
print(value)


print("------ReplaySubject------")
let replaySubjects = ReplaySubject<String>.create(bufferSize: 2)

replaySubjects.onNext("1. 첫번째")
replaySubjects.onNext("1. 두번째")
replaySubjects.onNext("1. 세번째")

replaySubjects.subscribe{
    print("첫번째 구독", $0.element ?? $0)
}.disposed(by: disposeBag)

replaySubjects.subscribe{
    print("두번째 구독", $0.element ?? $0)
}.disposed(by: disposeBag)

replaySubjects.onNext("4.네번째")
replaySubjects.onError(SubjectError.error1)
replaySubjects.dispose()
  
replaySubjects.subscribe{
    print("세번째 구독", $0.element ?? $0)
}.disposed(by: disposeBag)
