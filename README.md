# RxJS-haxe

## How to install

```bash
  haxelib git RxJS https://github.com/hachibeeDI/RxJS-haxe.git
```

add your `.hxml`

```
-lib RxJS
```


## Usage


```csharp
import rx.Observable;

// ATTENTION: static methods are all in `ObservableStatic` class.
var ob: Observable<js.html.Event> = ObservableStatic.fromEvent(null, "keyup");
```


## LICENCE

MIT
