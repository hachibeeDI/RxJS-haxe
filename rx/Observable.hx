package rx;

import rx.core.Interface;
import rx.scheduler.IScheduler;
import rx.scheduler.ICurrentThreadScheduler;
import rx.scheduler.Scheduler;
import rx.Observer;
import rx.promise.IPromise;


import js.html.EventListener;
import js.html.Event;


extern interface IObservable<T> {
  @:overload(function (observer: Observer<T>): IDisposable {})
    public function subscribe(
        ?onNext: T -> Void,
        ?onError: Dynamic -> Void,
        ?onCompleted: Void -> Void): IDisposable;
}


typedef SelectorFunc<T, U> = T -> Int -> Observable<T> -> U;
typedef Predicate<T> = T -> Int -> Observable<T> -> Bool;
// resolver, rejector
typedef PromiseResolver<T> = (T -> Void) -> (Dynamic -> Void);
typedef PromiseCtor<T, TPromise: IPromise<T>> = {
  function new (resolver: PromiseResolver<T> -> Void): TPromise;
}


@:native("Rx.Observable")
extern class Observable<T> implements IObservable<T> {

  // factory methods {{{

  /**
   * @param element:
   *   The DOMElement, NodeList, jQuery element, Zepto Element, Angular element,
   *   Ember.js element or EventEmitter to attach a listener. For Backbone.Marionette
   *   this would be the application or an EventAggregator object.
   */
  public static function fromEvent(element: Dynamic, eventName: String, ?selector: EventListener): Observable<Event>;


  /**
   * @param iterable (Array | Arguments | Iterable): An array-like or iterable object to convert to an Observable sequence.
   * @param [mapFn] (Function): Map function to call on every element of the array.
   * @param [thisArg] (Any): The context to use calling the mapFn if provided.
   * @param [scheduler=Rx.Scheduler.currentThread] (Scheduler): Scheduler to run the enumeration of the input sequence on.
   */
  @:generic
           public static function from<T>(
               iterable: Iterable<T>,
               /* ?mapFn: T -> U, */
               ?thisArg: Dynamic,
               scheduler: ICurrentThreadScheduler=Scheduler.currentThread
               ): Observable<T>;
  // }}}


  // instance methods {{{
  @:overload(function (observer: Observer<T>): IDisposable {})
  public function subscribe(
    ?onNext: T -> Void,
    ?onError: Dynamic -> Void,
    ?onCompleted: Void -> Void): IDisposable;

  /* alias for subscribe */
  public function forEach(?onNext: T -> Void, ?onError: Dynamic -> Void, ?onCompleted: Void -> Void): IDisposable;
  public function toArray(): Observable<Iterable<T>>;

  @:native('catch')
  @:overload(function(handler: Dynamic -> IPromise<T>): Observable<T> {})
  @:overload(function(second: Observable<T>): Observable<T> {})
  public function catch_(handler: Dynamic -> Observable<T>): Observable<T>;

  @:overload(function(handler: Dynamic -> IPromise<T>): Observable<T> {})
  @:overload(function(second: Observable<T>): Observable<T> {})
  public function catchException(handler: Dynamic -> Observable<T>): Observable<T>;  // alias for catch

  // public function combineLatest<T2, TResult>(second: Observable<T2>, resultSelector: (v1: T, v2: T2) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, TResult>(second: IPromise<T2>, resultSelector: (v1: T, v2: T2) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: Observable<T2>, third: Observable<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: Observable<T2>, third: IPromise<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: IPromise<T2>, third: Observable<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: IPromise<T2>, third: IPromise<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, T5, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, fifth: Observable<T5>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4, v5: T5) -> TResult): Observable<TResult>;
  // public function combineLatest<TOther, TResult>(souces: Observable<TOther>[], resultSelector: (firstValue: T, ...otherValues: Iterable<TOther>) -> TResult): Observable<TResult>;
  // public function combineLatest<TOther, TResult>(souces: IPromise<TOther>[], resultSelector: (firstValue: T, ...otherValues: Iterable<TOther>) -> TResult): Observable<TResult>;

  @:overload(function(source: IPromise<T>): Observable<T>{})
  public function concat(sources: Iterable<Observable<T>>): Observable<T>;
  public function concatAll(): T;
  // alias for concatAll
  public function concatObservable(): T;
  // public function concatMap<T2, R>(selector: (value: T, index: Int) -> Observable<T2>, resultSelector: (value1: T, value2: T2, index: Int) -> R): Observable<R>;  // alias for selectConcat
  // public function concatMap<T2, R>(selector: (value: T, index: Int) -> IPromise<T2>, resultSelector: (value1: T, value2: T2, index: Int) -> R): Observable<R>;  // alias for selectConcat
  // public function concatMap<R>(selector: (value: T, index: Int) -> Observable<R>): Observable<R>;  // alias for selectConcat
  // public function concatMap<R>(selector: (value: T, index: Int) -> IPromise<R>): Observable<R>;  // alias for selectConcat
  // public function concatMap<R>(sequence: Observable<R>): Observable<R>;  // alias for selectConcat

  @:overload(function(other: Observable<T>): Observable<T> {})
  @:overload(function(other: IPromise<T>): Observable<T> {})
  public function merge(maxConcurrent: Int): T;
  public function mergeAll(): T;
  // alias for mergeAll
  public function mergeObservable(): T;

  @:overload(function <T2>(other: IPromise<T2>): Observable<T> {})
  public function skipUntil<T2>(other: Observable<T2>): Observable<T>;

  @:native('switch')
  public function switch_(): T;
  public function switchLatest(): T;  // alias for switch

  @:overload(function <T2>(other: Observable<T2>): Observable<T> {})
  public function takeUntil<T2>(other: IPromise<T2>): Observable<T>;

  @:generic
  @:overload(function <T, T2, TResult>(second: Observable<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult> {})
  public function zip<T, T2, TResult>(second: IPromise<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: Observable<T2>, third: Observable<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: Observable<T2>, third: IPromise<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: IPromise<T2>, third: Observable<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: IPromise<T2>, third: IPromise<T3>, resultSelector: (v1: T, v2: T2, v3: T3) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, T5, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, fifth: Observable<T5>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4, v5: T5) -> TResult): Observable<TResult>;
  // public function zip<T, TOther, TResult>(second: Observable<TOther>[], resultSelector: (left: T, ...right: Iterable<TOther>) -> TResult): Observable<TResult>;
  // public function zip<T, TOther, TResult>(second: IPromise<TOther>[], resultSelector: (left: T, ...right: Iterable<TOther>) -> TResult): Observable<TResult>;

  public function asObservable(): Observable<T>;
  public function dematerialize<TOrigin>(): Observable<TOrigin>;

  @:overload(function (skipParameter: Bool, comparer: T -> T -> Bool): Observable<T> {})
  public function distinctUntilChanged<TValue>(?keySelector: T -> TValue, ?comparer: TValue -> TValue -> Bool): Observable<T>;

  @:native('do')
  @:overload(function (observer: Observer<T>): Observable<T> {})
  public function do_(?onNext: T -> Void, ?onError: Dynamic -> Void, ?onCompleted: Void -> Void): Observable<T>;
  // alias for do
  @:overload(function (observer: Observer<T>): Observable<T> {})
  public function doAction(?onNext: T -> Void, ?onError: Dynamic -> Void, ?onCompleted: Void -> Void): Observable<T>;

  public function finally(action: Void -> Void): Observable<T>;
  // alias for finally
  public function finallyAction(action: Void -> Void): Observable<T>;

  // public function ignoreElements(): Observable<T>;
  // public function materialize(): Observable<Notification<T>>;
  // public function repeat(?repeatCount: Int): Observable<T>;
  // public function retry(?retryCount: Int): Observable<T>;
  // public function scan<TAcc>(seed: TAcc, accumulator: (acc: TAcc, value: T) -> TAcc): Observable<TAcc>;
  // public function scan(accumulator: (acc: T, value: T) -> T): Observable<T>;
  // public function skipLast(count: Int): Observable<T>;
  // public function startWith(...values: Iterable<T>): Observable<T>;
  // public function startWith(scheduler: IScheduler, ...values: Iterable<T>): Observable<T>;
  // public function takeLast(count: Int, ?scheduler: IScheduler): Observable<T>;
  // public function takeLastBuffer(count: Int): Observable<Iterable<T>>;

  public function select<TResult>(
      selector: SelectorFunc<T,TResult >, ?thisArg: Dynamic): Observable<TResult>;
  // alias for select
  public function map<TResult>(
      selector: SelectorFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;
  // public function selectMany<TOther, TResult>(selector: (value: T) -> Observable<TOther>, resultSelector: (item: T, other: TOther) -> TResult): Observable<TResult>;
  // public function selectMany<TOther, TResult>(selector: (value: T) -> IPromise<TOther>, resultSelector: (item: T, other: TOther) -> TResult): Observable<TResult>;
  // public function selectMany<TResult>(selector: (value: T) -> Observable<TResult>): Observable<TResult>;
  // public function selectMany<TResult>(selector: (value: T) -> IPromise<TResult>): Observable<TResult>;
  // public function selectMany<TResult>(other: Observable<TResult>): Observable<TResult>;
  // public function selectMany<TResult>(other: IPromise<TResult>): Observable<TResult>;
  // public function flatMap<TOther, TResult>(selector: (value: T) -> Observable<TOther>, resultSelector: (item: T, other: TOther) -> TResult): Observable<TResult>;  // alias for selectMany
  // public function flatMap<TOther, TResult>(selector: (value: T) -> IPromise<TOther>, resultSelector: (item: T, other: TOther) -> TResult): Observable<TResult>;  // alias for selectMany
  // public function flatMap<TResult>(selector: (value: T) -> Observable<TResult>): Observable<TResult>;  // alias for selectMany
  // public function flatMap<TResult>(selector: (value: T) -> IPromise<TResult>): Observable<TResult>;  // alias for selectMany
  // public function flatMap<TResult>(other: Observable<TResult>): Observable<TResult>;  // alias for selectMany
  // public function flatMap<TResult>(other: IPromise<TResult>): Observable<TResult>;  // alias for selectMany

  // public function selectConcat<T2, R>(selector: (value: T, index: Int) -> Observable<T2>, resultSelector: (value1: T, value2: T2, index: Int) -> R): Observable<R>;
  // public function selectConcat<T2, R>(selector: (value: T, index: Int) -> IPromise<T2>, resultSelector: (value1: T, value2: T2, index: Int) -> R): Observable<R>;
  // public function selectConcat<R>(selector: (value: T, index: Int) -> Observable<R>): Observable<R>;
  // public function selectConcat<R>(selector: (value: T, index: Int) -> IPromise<R>): Observable<R>;
  // public function selectConcat<R>(sequence: Observable<R>): Observable<R>;

  /**
   *  Projects each element of an observable sequence into a new sequence of observable sequences by incorporating the element's index and then 
   *  transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence.
   * @param selector A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
   * @param [thisArg] Object to use as this when executing callback.
   * @returns An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences 
   *  and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
   */
  public function selectSwitch<TResult>(
      selector: SelectorFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;
  /**
   * alias for selectSwitch
   *  Projects each element of an observable sequence into a new sequence of observable sequences by incorporating the element's index and then 
   *  transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence.
   * @param selector A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
   * @param [thisArg] Object to use as this when executing callback.
   * @returns An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences 
   *  and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
   */
  public function flatMapLatest<TResult>(
      selector: SelectorFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;
  /**
   *  Projects each element of an observable sequence into a new sequence of observable sequences by incorporating the element's index and then 
   *  transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence.
   * @param selector A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
   * @param [thisArg] Object to use as this when executing callback.
   * @since 2.2.28
   * @returns An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences 
   *  and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
   */
  public function switchMap<TResult>(selector: SelectorFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;  // alias for selectSwitch

  public function skip(count: Int): Observable<T>;
  public function skipWhile(predicate: Predicate<T>, ?thisArg: Dynamic): Observable<T>;
  public function take(count: Int, ?scheduler: IScheduler): Observable<T>;
  public function takeWhile(predicate: Predicate<T>, ?thisArg: Dynamic): Observable<T>;
  public function where(predicate: Predicate<T>, ?thisArg: Dynamic): Observable<T>;
  // alias for where
  public function filter(predicate: Predicate<T>, ?thisArg: Dynamic): Observable<T>;

  /**
   * Converts an existing observable sequence to an ES6 Compatible Promise
   * @example
   * var promise = Rx.Observable.return(42).toPromise(RSVP.Promise);
   * @param promiseCtor The constructor of the promise.
   * @returns An ES6 compatible promise with the last value from the observable sequence.
   * -----------------------------------------------------------------------------------------------------------
   * Converts an existing observable sequence to an ES6 Compatible Promise
   * @example
   * var promise = Rx.Observable.return(42).toPromise(RSVP.Promise);
   * 
   * // With config
   * Rx.config.Promise = RSVP.Promise;
   * var promise = Rx.Observable.return(42).toPromise();
   * @param [promiseCtor] The constructor of the promise. If not provided, it looks for it in Rx.config.Promise.
   * @returns An ES6 compatible promise with the last value from the observable sequence.
   */
  @:overload(function <TPromise: IPromise<T>>(promiseCtor: PromiseCtor<T, TPromise>): TPromise {})
  public function toPromise<TPromise: IPromise<T>>(?promiseCtor: PromiseCtor<T, TPromise>): IPromise<T>;

  // Experimental Flattening

  /**
   * Performs a exclusive waiting for the first to finish before subscribing to another observable.
   * Observables that come in between subscriptions will be dropped on the floor.
   * Can be applied on `Observable<Observable<R>>` or `Observable<IPromise<R>>`.
   * @since 2.2.28
   * @returns A exclusive observable with only the results that happen when subscribed.
   */
  public function exclusive<R>(): Observable<R>;

  /**
   * Performs a exclusive map waiting for the first to finish before subscribing to another observable.
   * Observables that come in between subscriptions will be dropped on the floor.
   * Can be applied on `Observable<Observable<I>>` or `Observable<IPromise<I>>`.
   * @since 2.2.28
   * @param selector Selector to invoke for every item in the current subscription.
   * @param [thisArg] An optional context to invoke with the selector parameter.
   * @returns {An exclusive observable with only the results that happen when subscribed.
   */
  public function exclusiveMap<I, R>(selector: SelectorFunc<I, R>, ?thisArg: Dynamic): Observable<R>;


  public function throttle(dueTime: Int, ?scheduler: IScheduler): Observable<T>;
  // }}}
}
