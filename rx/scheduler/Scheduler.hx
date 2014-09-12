package rx.scheduler;

import rx.scheduler.ICurrentThreadScheduler;


@:native('Rx.Scheduler')
extern class Scheduler implements IScheduler {
  public static var currentThread(default, null): ICurrentThreadScheduler;
}
