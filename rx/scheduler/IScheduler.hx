package rx.scheduler;


extern interface IScheduler {
  // now(): number;
  //
  // schedule(action: () => void): IDisposable;
  // scheduleWithState<TState>(state: TState, action: (scheduler: IScheduler, state: TState) => IDisposable): IDisposable;
  // scheduleWithAbsolute(dueTime: number, action: () => void): IDisposable;
  // scheduleWithAbsoluteAndState<TState>(state: TState, dueTime: number, action: (scheduler: IScheduler, state: TState) =>IDisposable): IDisposable;
  // scheduleWithRelative(dueTime: number, action: () => void): IDisposable;
  // scheduleWithRelativeAndState<TState>(state: TState, dueTime: number, action: (scheduler: IScheduler, state: TState) =>IDisposable): IDisposable;
  //
  // scheduleRecursive(action: (action: () =>void ) =>void ): IDisposable;
  // scheduleRecursiveWithState<TState>(state: TState, action: (state: TState, action: (state: TState) =>void ) =>void ): IDisposable;
  // scheduleRecursiveWithAbsolute(dueTime: number, action: (action: (dueTime: number) => void) => void): IDisposable;
  // scheduleRecursiveWithAbsoluteAndState<TState>(state: TState, dueTime: number, action: (state: TState, action: (state: TState, dueTime: number) => void) => void): IDisposable;
  // scheduleRecursiveWithRelative(dueTime: number, action: (action: (dueTime: number) =>void ) =>void ): IDisposable;
  // scheduleRecursiveWithRelativeAndState<TState>(state: TState, dueTime: number, action: (state: TState, action: (state: TState, dueTime: number) =>void ) =>void ): IDisposable;
  //
  // schedulePeriodic(period: number, action: () => void): IDisposable;
  // schedulePeriodicWithState<TState>(state: TState, period: number, action: (state: TState) => TState): IDisposable;
}
