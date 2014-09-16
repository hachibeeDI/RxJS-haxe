package rx.core;


@:native("Rx.IDisposable")
extern interface IDisposable {
  function dispose(): Void;
}


extern class CompositeDisposable implements IDisposable {
  var isDisposed(default, null): Bool;
  var length(default, null): Int;

  public function new (disposables: Iterable<IDisposable>);


  public function dispose(): Void;
  public function add(item: IDisposable): Void;
  public function remove(item: IDisposable): Bool;
  public function clear(): Void;
  public function contains(item: IDisposable): Bool;
  public function toArray(): IDisposable[];
}

extern class Disposable implements IDisposable {
  public static var empty(default, null): IDisposable;

  public function new(action: Void -> Void);

  public static function create(action: Void -> Void): IDisposable;

  public function dispose(): Void;
}
