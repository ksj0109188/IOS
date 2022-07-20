import RxSwift
import Foundation
let disposeBag = DisposeBag()

enum TraitError:Error {
    case single
    case maybe
    case completable
}

print("---------Single1---------")
Single<String>.just("❤️") //Single Type 생성방식 1
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0)")
        }
        ,onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)
//Observable<String>.just()
//    .subscribe(
//        onNext:{
//        }
//        , onError:{
//        }
//        , onCompleted:{
//        }
//        , onDisposed:{
//        }
//)

print("---------Single2---------")
Observable<String>.just("❤️")
    .asSingle() //observer Single Type 생성방식 2
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0)")
        }
        ,onDisposed: {
            print("disposed")
        }
)
    .disposed(by: disposeBag)

print("---------Single3---------")
Observable<String>.create({ observer -> Disposable in
    observer.onError(TraitError.single)
    return Disposables.create()
})
    .asSingle()
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0.localizedDescription)")
        }
        ,onDisposed: {
            print("disposed")
        }
    ).disposed(by: disposeBag)


print("---------Single4---------")
struct SomeJSON: Decodable{
    let name: String
}

enum JSONError:Error {
    case decodingError
}

let json1 = """
            {"name":"park"}
            """

let json2 = """
            {"WronName":"park"}
            """

func decode(json:String) -> Single<SomeJSON>{
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self,from: data)
        else{
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        observer(.success(json)) //json 객체를 success이벤트에 담아 발생시킴
        return Disposables.create()
    }
}

decode(json: json1).subscribe(
    onSuccess: {
        print($0.name)
        print($0)
    },
    onFailure: {
        print($0.localizedDescription)
    },
    onDisposed: {
        print("Disposed")
    })

decode(json: json2)
    .subscribe{ $0
        switch $0{
        case .success(let json):
            print($0)
        case .failure(let error):
            print(error)
        }
}
.disposed(by: disposeBag)

print("-------Maybe1-------")
Maybe<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        }, onError: {
            print($0)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })
    .disposed(by: disposeBag)

print("-------Maybe2-------")
Observable<String>.create { observable -> Disposable in
    observable.onError(TraitError.maybe)
    return Disposables.create()
}.asMaybe()
    .subscribe(
        onSuccess: {
            print("성공 \($0)")
        }, onError: {
            print("에러 \($0)")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })
    .disposed(by: disposeBag)

print("-------Completable-------")
Completable.create { observer -> Disposable in
    observer(.error(TraitError.completable))
    return Disposables.create()
}.subscribe(
    onCompleted:{
        print("completed")
    }
    , onError:{
        print("에러 : \($0)")
    }
    , onDisposed:{
        
    }
)
