class DoubleArgs {
  final String arg1;
  final String arg2;
  DoubleArgs({
    required this.arg1,
    required this.arg2,
  });

  @override
  String toString() => 'DoubleArgs(arg1: $arg1, arg2: $arg2)';

  @override
  bool operator ==(covariant DoubleArgs other) {
    if (identical(this, other)) return true;

    return other.arg1 == arg1 && other.arg2 == arg2;
  }

  @override
  int get hashCode => arg1.hashCode ^ arg2.hashCode;
}

class DoubleArgsTime {
  final DateTime arg1;
  final DateTime arg2;
  DoubleArgsTime({
    required this.arg1,
    required this.arg2,
  });

  @override
  String toString() => 'DoubleArgs(arg1: $arg1, arg2: $arg2)';

  @override
  bool operator ==(covariant DoubleArgsTime other) {
    if (identical(this, other)) return true;

    return other.arg1 == arg1 && other.arg2 == arg2;
  }

  @override
  int get hashCode => arg1.hashCode ^ arg2.hashCode;
}

class DoubleArgsPaginate {
  final int start;
  final int end;
  DoubleArgsPaginate({
    required this.start,
    required this.end,
  });

  @override
  String toString() => 'DoubleArgs(arg1: $start, arg2: $end)';

  @override
  bool operator ==(covariant DoubleArgsPaginate other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
