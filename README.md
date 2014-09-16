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

var ob: Observable<js.html.Event> = Observable.fromEvent(null, 'keyup');
```
