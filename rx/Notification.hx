package rx;

import rx.core.Interface;
import rx.Observer;
import rx.Observable;
import rx.scheduler.IScheduler;

@:native('Rx.Notification')
extern class Notification<T> {
  public var hasValue(default, null): Bool;
  public var kind(default, null): String;
  public var value(default, null): T;
  /* Gets the exception from the OnError notification. */
  public var exception(default, null): Dynamic;

  /**
    * Invokes the delegate corresponding to the notification or the observer's method
    * corresponding to the notification and returns the produced result.
    * @params [observer] (Observer): Observer to invoke the notification on.
    * @params [onNext] (Function): Function to invoke for an OnNext notification.
    * @params [onError] (Function): Function to invoke for an OnError notification.
    * @params [onError] (Function): Function to invoke for an OnCompleted notification.
   */
  @:overload(function (observer: IObserver<T>): Void {})
  public function accept<TResult>(onNext: T -> TResult, ?onError: Void -> TResult, ?onCompleted: Void -> TResult): TResult;

  public function toObservable(?scheduler: IScheduler): Observable<T>;
  public function equals(other: Notification<T>): Bool;

  public static function createOnNext<T>(value: T): Notification<T>;
  public static function createOnError<T>(exception: Void): Notification<T>;
  public static function createOnCompleted<T>(): Notification<T>;
}
