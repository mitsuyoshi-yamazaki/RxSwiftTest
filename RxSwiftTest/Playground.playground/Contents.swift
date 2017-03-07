//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Hello, playground"
print(str)

typealias StrClosure = (String) -> Void

class ObjectToDeinit {
  
  let bag = DisposeBag()

  init(_ observable: Observable<String>) {
    print(#function)
    
    
    
    observable.subscribe(onNext: { [weak self] (str) in
      print("onNext: \(str)")
      self?.printText(str)
    }, onError: { (error) in
      print("onError: \(error)")
    }).addDisposableTo(bag)
  }
  
  deinit {
    print(#function)
  }
  
  // MARK: - 
  private func printText(_ text: String) {
    print("\(#function): \(text)")
  }
}

let subject = PublishSubject<String>()
let observable = subject.asObservable()

var obj: ObjectToDeinit? = ObjectToDeinit(observable)
obj = nil

subject.onNext("🍎")