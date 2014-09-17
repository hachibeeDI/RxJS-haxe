package rx;

import rx.core.Interface;
import rx.scheduler.IScheduler;
import rx.scheduler.ICurrentThreadScheduler;
import rx.scheduler.Scheduler;
import rx.Observer;
import rx.Notification;
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


typedef SelectorWithIndexFunc<T, TResult> = T -> Int -> TResult;
typedef SelectorWithObservableFunc<T, U> = T -> Int -> Observable<T> -> U;
typedef Predicate<T> = T -> Int -> Observable<T> -> Bool;

// resolver, rejector
typedef PromiseResolver<T> = (T -> Void) -> (Dynamic -> Void);
typedef PromiseCtor<T, TPromise: IPromise<T>> = {
  function new (resolver: PromiseResolver<T> -> Void): TPromise;
}



/**
  * NOTE: Haxe cannot have duplicated field even if instance method and static methods.
 */
@:native("Rx.Observable")
extern class ObservableStatic<T> {
// static methods {{{
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
  public static function from<T, TResult>(
    iterable: Iterable<T>,
    ?mapFn: SelectorWithIndexFunc<T, TResult>,
    ?thisArg: Dynamic,
    ?scheduler: ICurrentThreadScheduler=Scheduler.currentThread
    ): Observable<T>;

  // TODO: I have no idea How to make [] accesable type in Haxe.
  //  /**
  //  * This method creates a new Observable sequence from an array-like object.
  //  * @param array An array-like or iterable object to convert to an Observable sequence.
  //  * @param mapFn Map function to call on every element of the array.
  //  * @param [thisArg] The context to use calling the mapFn if provided.
  //  * @param [scheduler] Optional scheduler to use for scheduling.  If not provided, defaults to Scheduler.currentThread.
  //  */
  //  from<T, TResult>(
  //      array: { length: Int, [index: Int]: T; },
  //      mapFn: T -> Int -> TResult,
  //      ?thisArg: Void,
  //      ?scheduler: IScheduler)
  //    : Observable<TResult>;

  // /**
  // * This method creates a new Observable sequence from an array-like object.
  // * @param array An array-like or iterable object to convert to an Observable sequence.
  // * @param [mapFn] Map function to call on every element of the array.
  // * @param [thisArg] The context to use calling the mapFn if provided.
  // * @param [scheduler] Optional scheduler to use for scheduling.  If not provided, defaults to Scheduler.currentThread.
  // */
  // from<T>(array: { length: Int;[index: Int]: T; }, ?mapFn: (value: T, index: Int) -> T, ?thisArg: Void, ?scheduler: IScheduler): Observable<T>;


  @:overload(function <T>(subscribe: Observer<T> -> IDisposable): Observable<T> {})
  @:overload(function <T>(subscribe: Observer<T> -> Void -> Void): Observable<T> {})
  public static function create<T>(subscribe: Observer<T> -> Void): Observable<T>;
  public static function createWithDisposable<T>(subscribe: Observer<T> -> IDisposable): Observable<T>;
  @:overload(function <T>(observableFactory: Void -> Observable<T>): Observable<T> {})
  public static function defer<T>(observableFactory: Void -> IPromise<T>): Observable<T>;
  public static function empty<T>(?scheduler: IScheduler): Observable<T>;


  @:overload(function <T>(array: Array<T>, ?scheduler: IScheduler): Observable<T> {})
  public static function fromArray<T>(array: Iterable<T>, ?scheduler: IScheduler): Observable<T>;

  /**
  *  Converts an iterable into an Observable sequence
  *  
  * @example
  *  var res = Rx.Observable.fromIterable(new Map());
  *  var res = Rx.Observable.fromIterable(function* () { yield 42; });
  *  var res = Rx.Observable.fromIterable(new Set(), Rx.Scheduler.timeout);
  * @param generator Generator to convert from.
  * @param [scheduler] Scheduler to run the enumeration of the input sequence on.
  * @returns The observable sequence whose elements are pulled from the given generator sequence.
  */
  @:overload(function <T>(generator: Void -> { next: Void -> { done: Bool, ?value: T } }, ?scheduler: IScheduler): Observable<T> {})
  /**
  *  Converts an iterable into an Observable sequence
  *  
  * @example
  *  var res = Rx.Observable.fromIterable(new Map());
  *  var res = Rx.Observable.fromIterable(new Set(), Rx.Scheduler.timeout);
  * @param iterable Iterable to convert from.
  * @param [scheduler] Scheduler to run the enumeration of the input sequence on.
  * @returns The observable sequence whose elements are pulled from the given generator sequence.
  * todo: can't describe ES6 Iterable via TypeScript type system
  */
  public static function fromItreable<T>(iterable: {}, ?scheduler: IScheduler): Observable<T>;
  public static function generate<TState, TResult>(initialState: TState, condition: TState -> Bool, iterate: TState -> TState, resultSelector: TState -> TResult, ?scheduler: IScheduler): Observable<TResult>;
  public static var never(default, null): Observable<T>;

  /**
  *  This method creates a new Observable instance with a variable Int of arguments, regardless of Int or type of the arguments.
  * 
  * @example
  *  var res = Rx.Observable.of(1, 2, 3);
  * @since 2.2.28
  * @returns The observable sequence whose elements are pulled from the given arguments.
  */
  public static function of<T>(values: Array<T>): Observable<T>;

  /**
  *  This method creates a new Observable instance with a variable Int of arguments, regardless of Int or type of the arguments. 
  * @example
  *  var res = Rx.Observable.ofWithScheduler(Rx.Scheduler.timeout, 1, 2, 3);
  * @since 2.2.28
  * @param [scheduler] A scheduler to use for scheduling the arguments.
  * @returns The observable sequence whose elements are pulled from the given arguments.
  */
  public static function ofWithScheduler<T>(?scheduler: IScheduler, values: Array<T>): Observable<T>;
  public static function range(start: Int, count: Int, ?scheduler: IScheduler): Observable<Int>;
  public static function repeat<T>(value: T, ?repeatCount: Int, ?scheduler: IScheduler): Observable<T>;
  @:native("return")
  public static function return_<T>(value: T, ?scheduler: IScheduler): Observable<T>;
  /**
    * @since 2.2.28
    */
  public static function just<T>(value: T, ?scheduler: IScheduler): Observable<T>;  // alias for return
  public static function returnValue<T>(value: T, ?scheduler: IScheduler): Observable<T>;  // alias for return
  @:native("throw")
  @:overload(function <T>(exception: Dynamic, ?scheduler: IScheduler): Observable<T> {})
  public static function throw_<T>(exception: Void, ?scheduler: IScheduler): Observable<T>;
  /**
    * alias for throw
   */
  @:overload(function <T>(exception: Dynamic, ?scheduler: IScheduler): Observable<T> {})
  public static function throwException<T>(exception: Void, ?scheduler: IScheduler): Observable<T>;  // alias for throw

  @:native("catch")
  @:overload(function <T>(sources: Array<Observable<T>>): Observable<T> {})
  public static function catch_<T>(sources: Array<IPromise<T>>): Observable<T>;
  /**
    * alias for catch
   */
  @:overload(function <T>(sources: Array<Observable<T>>): Observable<T> {})
  public static function catchException<T>(sources: Array<IPromise<T>>): Observable<T>;  // alias for catch

  @:overload(function <T, T2, TResult>(first: Observable<T>, second: Observable<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult> {})
  public static function combineLatest<T, T2, TResult>(
    first: IPromise<T>, second: Observable<T2>, resultSelector: T -> T2 -> TResult
    ): Observable<TResult>;
  // combineLatest<T, T2, TResult>(first: Observable<T>, second: IPromise<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, TResult>(first: IPromise<T>, second: IPromise<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: Observable<T>, second: Observable<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: Observable<T>, second: Observable<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: Observable<T>, second: IPromise<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: Observable<T>, second: IPromise<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: IPromise<T>, second: Observable<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: IPromise<T>, second: Observable<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: IPromise<T>, second: IPromise<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, TResult>(first: IPromise<T>, second: IPromise<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: Observable<T>, second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, TResult>(first: IPromise<T>, second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // combineLatest<T, T2, T3, T4, T5, TResult>(first: Observable<T>, second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, fifth: Observable<T5>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4, v5: T5) -> TResult): Observable<TResult>;
  // combineLatest<TOther, TResult>(souces: Array<Observable<TOther>>, resultSelector: (otherValues: Array<TOther>) -> TResult): Observable<TResult>;
  // combineLatest<TOther, TResult>(souces: Array<IPromise<TOther>>, resultSelector: (otherValues: Array<TOther>) -> TResult): Observable<TResult>;

  @:overload(function <T>(sources: Array<Observable<T>>): Observable<T> {})
  public static function concat<T>(sources: Array<IPromise<T>>): Observable<T>;

  @:overload(function <T>(sources: Array<Observable<T>>): Observable<T> {})
  @:overload(function <T>(sources: Array<IPromise<T>>): Observable<T> {})
  @:overload(function <T>(scheduler: IScheduler, sources: Array<Observable<T>>): Observable<T> {})
  public static function merge<T>(scheduler: IScheduler, sources: Array<IPromise<T>>): Observable<T>;

  @:overload(function <T1, T2, TResult>(
    first: Observable<T1>, sources: Array<Observable<T2>>, resultSelector: T1 -> Array<T2> -> TResult): Observable<TResult> {})
  @:overload(function <T1, T2, TResult>(
    first: Observable<T1>, sources: Array<IPromise<T2>>, resultSelector: T1 -> Array<T2> -> TResult): Observable<TResult> {})
  @:overload(function <T1, T2, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, resultSelector: T1 -> T2 -> TResult): Observable<TResult> {})
  @:overload(function <T1, T2, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, resultSelector: T1 -> T2 -> TResult): Observable<TResult> {})
  @:overload(function <T1, T2, T3, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: Observable<T3>, resultSelector: T1 -> T2 -> T3 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: IPromise<T3>, resultSelector: T1 -> T2 -> T3 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: Observable<T3>, resultSelector: T1 -> T2 -> T3 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: IPromise<T3>, resultSelector: T1 -> T2 -> T3 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: Observable<T3>, source4: Observable<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: Observable<T3>, source4: IPromise<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: IPromise<T3>, source4: Observable<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: Observable<T2>, source3: IPromise<T3>, source4: IPromise<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: Observable<T3>, source4: Observable<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: Observable<T3>, source4: IPromise<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: IPromise<T3>, source4: Observable<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  @:overload(function <T1, T2, T3, T4, TResult>(
    source1: Observable<T1>, source2: IPromise<T2>, source3: IPromise<T3>, source4: IPromise<T4>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> TResult
  ): Observable<TResult> {})
  public static function zip<T1, T2, T3, T4, T5, TResult>(
    source1: Observable<T1>,
    source2: Observable<T2>,
    source3: Observable<T3>,
    source4: Observable<T4>,
    source5: Observable<T5>,
    resultSelector: T1 -> T2 -> T3 -> T4 -> T5 -> TResult
 ): Observable<TResult>;

  public static function zipArray<T>(sources: Array<Array<Observable<T>>>): Observable<Array<T>>;

  /**
  * Converts a Promise to an Observable sequence
  * @param promise An ES6 Compliant promise.
  * @returns An Observable sequence which wraps the existing promise success and failure.
  */
  public static function fromPromise<T>(promise: IPromise<T>): Observable<T>;

// }}}
}


@:native("Rx.Observable")
extern class Observable<T> implements IObservable<T> {
  // instance methods {{{
  @:overload(function (observer: Observer<T>): IDisposable {})
  public function subscribe(
    ?onNext: T -> Void,
    ?onError: Dynamic -> Void,
    ?onCompleted: Void -> Void): IDisposable;

  /* alias for subscribe */
  public function forEach(?onNext: T -> Void, ?onError: Dynamic -> Void, ?onCompleted: Void -> Void): IDisposable;
  public function toArray(): Observable<Iterable<T>>;

  // @:native('catch')
  // @:overload(function(handler: Dynamic -> IPromise<T>): Observable<T> {})
  // @:overload(function(second: Observable<T>): Observable<T> {})
  // public function catch_(handler: Dynamic -> Observable<T>): Observable<T>;

  /* alias for catch */
  @:overload(function(handler: Dynamic -> IPromise<T>): Observable<T> {})
  @:overload(function(second: Observable<T>): Observable<T> {})
  public function catchException(handler: Dynamic -> Observable<T>): Observable<T>;

  @:overload(function <T2, TResult>(second: Observable<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult> {})
  public function combineLatest<T2, TResult>(second: IPromise<T2>, resultSelector: T -> T2 -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: Observable<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: Observable<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: IPromise<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, TResult>(second: IPromise<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function combineLatest<T2, T3, T4, T5, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, fifth: Observable<T5>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4, v5: T5) -> TResult): Observable<TResult>;
  // public function combineLatest<TOther, TResult>(souces: Array<Observable<TOther>>, resultSelector: (firstValue: T, ...otherValues: Iterable<TOther>) -> TResult): Observable<TResult>;
  // public function combineLatest<TOther, TResult>(souces: Array<IPromise<TOther>>, resultSelector: (firstValue: T, ...otherValues: Iterable<TOther>) -> TResult): Observable<TResult>;

  @:overload(function(source: IPromise<T>): Observable<T>{})
  public function concat(sources: Iterable<Observable<T>>): Observable<T>;
  public function concatAll(): T;
  // alias for concatAll
  public function concatObservable(): T;

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
  // public function zip<T, T2, T3, TResult>(second: Observable<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: Observable<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: IPromise<T2>, third: Observable<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, TResult>(second: IPromise<T2>, third: IPromise<T3>, resultSelector: T -> T2 -> T3 -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: Observable<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: Observable<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: Observable<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, TResult>(second: IPromise<T2>, third: IPromise<T3>, fourth: IPromise<T4>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4) -> TResult): Observable<TResult>;
  // public function zip<T, T2, T3, T4, T5, TResult>(second: Observable<T2>, third: Observable<T3>, fourth: Observable<T4>, fifth: Observable<T5>, resultSelector: (v1: T, v2: T2, v3: T3, v4: T4, v5: T5) -> TResult): Observable<TResult>;
  // public function zip<T, TOther, TResult>(second: Array<Observable<TOther>>, resultSelector: (left: T, ...right: Iterable<TOther>) -> TResult): Observable<TResult>;
  // public function zip<T, TOther, TResult>(second: Array<IPromise<TOther>>, resultSelector: (left: T, ...right: Iterable<TOther>) -> TResult): Observable<TResult>;

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

  public function ignoreElements(): Observable<T>;
  public function materialize(): Observable<Notification<T>>;
  public function repeat(?repeatCount: Int): Observable<T>;
  public function retry(?retryCount: Int): Observable<T>;
  @:overload(function <TAcc>(seed: TAcc, accumulator: TAcc -> T -> TAcc): Observable<TAcc> {})
  public function scan(accumulator: T -> T -> T): Observable<T>;
  public function skipLast(count: Int): Observable<T>;
  @:overload(function (values: Iterable<T>): Observable<T> {})
  public function startWith(scheduler: IScheduler, values: Iterable<T>): Observable<T>;
  public function takeLast(count: Int, ?scheduler: IScheduler): Observable<T>;
  public function takeLastBuffer(count: Int): Observable<Iterable<T>>;

  public function select<TResult>(
      selector: SelectorWithObservableFunc<T,TResult >, ?thisArg: Dynamic): Observable<TResult>;
  // alias for select
  public function map<TResult>(selector: SelectorWithObservableFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;

  @:overload(function <TOther, TResult>(selector: T -> Observable<TOther>, resultSelector: T -> TOther -> TResult): Observable<TResult> {})
  @:overload(function <TOther, TResult>(selector: T -> IPromise<TOther>, resultSelector: T -> TOther -> TResult): Observable<TResult> {})
  @:overload(function <TResult>(selector: T -> Observable<TResult>): Observable<TResult> {})
  @:overload(function <TResult>(selector: T -> IPromise<TResult>): Observable<TResult> {})
  @:overload(function <TResult>(other: Observable<TResult>): Observable<TResult> {})
  public function selectMany<TResult>(other: IPromise<TResult>): Observable<TResult>;

  // alias for selectMany
  @:overload(function <TOther, TResult>(selector: T -> Observable<TOther>, resultSelector: T -> TOther -> TResult): Observable<TResult> {})
  @:overload(function <TOther, TResult>(selector: T -> IPromise<TOther>, resultSelector: T -> TOther -> TResult): Observable<TResult> {})
  @:overload(function <TResult>(selector: T -> Observable<TResult>): Observable<TResult> {})
  @:overload(function <TResult>(selector: T -> IPromise<TResult>): Observable<TResult> {})
  @:overload(function <TResult>(other: Observable<TResult>): Observable<TResult> {})
  public function flatMap<TResult>(other: IPromise<TResult>): Observable<TResult>;

  @:overload(function <T2, R>(selector: T -> Int -> Observable<T2>, resultSelector: T -> T2 -> Int -> R): Observable<R> {})
  @:overload(function <T2, R>(selector: T -> Int -> IPromise<T2>, resultSelector: T -> T2 -> Int -> R): Observable<R> {})
  @:overload(function <R>(selector: T -> Int -> Observable<R>): Observable<R> {})
  @:overload(function <R>(selector: T -> Int -> IPromise<R>): Observable<R> {})
  public function selectConcat<R>(sequence: Observable<R>): Observable<R>;

  // alias for selectConcat
  @:overload(function <T2, R>(selector: T -> Int -> Observable<T2>, resultSelector: T -> T2 -> Int -> R): Observable<R> {})
  @:overload(function <T2, R>(selector: T -> Int -> IPromise<T2>, resultSelector: T -> T2 -> Int -> R): Observable<R> {})
  @:overload(function <R>(selector: T -> Int -> Observable<R>): Observable<R> {})
  @:overload(function <R>(selector: T -> Int -> IPromise<R>): Observable<R> {})
  public function concatMap<R>(sequence: Observable<R>): Observable<R>;

  /**
   *  Projects each element of an observable sequence into a new sequence of observable sequences by incorporating the element's index and then 
   *  transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence.
   * @param selector A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
   * @param [thisArg] Object to use as this when executing callback.
   * @returns An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences 
   *  and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
   */
  public function selectSwitch<TResult>(
      selector: SelectorWithObservableFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;
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
      selector: SelectorWithObservableFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;
  /**
   *  Projects each element of an observable sequence into a new sequence of observable sequences by incorporating the element's index and then 
   *  transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence.
   * @param selector A transform function to apply to each source element; the second parameter of the function represents the index of the source element.
   * @param [thisArg] Object to use as this when executing callback.
   * @since 2.2.28
   * @returns An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences 
   *  and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
   */
  public function switchMap<TResult>(selector: SelectorWithObservableFunc<T, TResult>, ?thisArg: Dynamic): Observable<TResult>;  // alias for selectSwitch

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
  public function exclusiveMap<I, R>(selector: SelectorWithObservableFunc<I, R>, ?thisArg: Dynamic): Observable<R>;


  public function throttle(dueTime: Int, ?scheduler: IScheduler): Observable<T>;
  // }}}
}
