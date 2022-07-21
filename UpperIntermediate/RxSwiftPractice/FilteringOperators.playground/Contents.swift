import RxSwift

let disposeBag = DisposeBag()
print("---------ignoreElements Operator---------") //이벤트 발생 무시, onComplete만 받음
let 취침모드🥱 = PublishSubject<String>()

취침모드🥱
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취침모드🥱.onNext("🔊")
취침모드🥱.onNext("🔊")
취침모드🥱.onNext("🔊")

취침모드🥱.onCompleted()


print("---------elementAt Operator---------")
let 두번울면깨는사람 = PublishSubject<String>()
    
두번울면깨는사람
    .element(at: 2) //operator
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔊1")
두번울면깨는사람.onNext("🔊2")
두번울면깨는사람.onNext("🔊3") //index 2
두번울면깨는사람.onNext("🔊4")
두번울면깨는사람.onNext("🔊5")


print("---------Filter Operator---------")
Observable.of(1,2,3,4,5,6,7,8) // 이벤트 방출
    .filter{ $0 % 2 == 0} //필터를 통과한 것만 방출
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

print("---------skip---------")
Observable<Int>.of(1,2,3,4,5,6)
    .skip(5)
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

print("---------skipWhile---------") //filter와 달리 특정 조건을 만족하면 계속 Skip false면 이벤트 발생
Observable.of("❤️","😘","☺️","👍🏻","🔊")
    .skip(while: {
        $0 != "☺️"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("---------skipUntil---------")
let 손님 = PublishSubject<String>()
let 가게문여는시간 = PublishSubject<String>()

손님.skip(until: 가게문여는시간) //가게문여는시간 observable이 이벤트 발생 전까지 계속 Skip
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("❤️")
손님.onNext("😘")

가게문여는시간.onNext("Start!!!")
손님.onNext("🔊")

print("---------take---------") //skip의 반대개념
Observable.of("금","은","동","파리","로마")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------takeWhile---------")
Observable.of("금","은","동","파리","로마")
    .take(while: {
        $0 != "동" // false가되면 Subscribe Stop
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------enumerated---------") //방출되는 이벤트 Element 및 그에 해당하는 인덱스가 튜플형태로 방출됨
Observable.of("금","은","동","파리","로마")
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

print("---------takeUnitl---------") //방출되는 이벤트 Element 및 그에 해당하는 인덱스가 튜플형태로 방출됨
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청.take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("수학")
수강신청.onNext("영어")

신청마감.onNext("신청마감")
수강신청.onNext("과학")

print("---------distinctUntilChanged---------")
Observable.of("저는","저는","김성준","김성준","김성준","입니다","입니다","저는","저는","김성준","일까요")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
