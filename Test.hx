package;

import rx.Observable;


class Test {

  public static function main() {
    var ob: Observable<js.html.Event> = ObservableStatic.fromEvent(null, 'keyup');
    var ob: Observable<Int> = ObservableStatic.from([1, 2, 3, 4, 5]);
    ob.catchException((function(x) {return null;}));
  }
}
