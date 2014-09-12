package rx.scheduler;




extern interface ICurrentThreadScheduler extends IScheduler {
  public function scheduleRequired(): Bool;
}

