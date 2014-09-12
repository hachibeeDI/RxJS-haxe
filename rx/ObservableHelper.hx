package rx;


class ObservableHelper {
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
    scheduler: rx.ICurrentThreadScheduler=rx.Scheduler.currentThread
  ): Observable<T>;
  // }}}


}
