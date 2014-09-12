package rx.promise;


typedef OnFulfilledWithPromise<T, R> = T -> IPromise<R>;
typedef OnRejectedWithPromise<R> = Void -> IPromise<R>;
typedef OnFulfilled<T, R> = T -> R;
typedef OnRejected<R> = Void -> R;


/**
 * Promise A+
 */
interface IPromise<T> {
  @:overload(function <R>(onFulfilled: OnFulfilledWithPromise<T, R>, onRejected: OnRejectedWithPromise<R>): IPromise<R> {})
  @:overload(function <R>(onFulfilled: OnFulfilledWithPromise<T, R>, ?onRejected: OnRejected<R>): IPromise<R> {})
  @:overload(function <R>(onFulfilled: OnFulfilled<T, R>, ?onRejected: OnRejected<R>): IPromise<R> {})
  public function then<R>(): IPromise<R>;
}
