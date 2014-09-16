package;

import rx.Observable;


class Test {

  public static function main() {
    var ob: Observable<js.html.Event> = rx.Observable.fromEvent(null, 'keyup');
    var ob: Observable<Int> = rx.Observable.from([1, 2, 3, 4, 5]);
    ob.catch_(function(x) {return null;});
  }
}
