// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:riverpod_annotation/riverpod_annotation.dart';

final isLastPageProvider =
    NotifierProvider<IsLastPageNotifier, PaginationState>(
        IsLastPageNotifier.new);

class IsLastPageNotifier extends Notifier<PaginationState> {
  @override
  build() {
    return PaginationState(isLoading: false, isLastpage: false);
  }

  void setLoadingTrue() {
    final updatedState = state.copyWith(isLoading: true);
    state = updatedState;
  }

  void setLoadingFalse() {
    final updatedState = state.copyWith(isLoading: false);

    state = updatedState;
  }

  void setLastPageTrue() {
    final updatedState = state.copyWith(isLastpage: true);
    state = updatedState;
  }

  void setLastPageFalse() {
    final updatedState = state.copyWith(isLastpage: false);

    state = updatedState;
  }
}

class PaginationState {
  final bool isLoading;
  final bool isLastpage;
  PaginationState({
    required this.isLoading,
    required this.isLastpage,
  });

  PaginationState copyWith({
    bool? isLoading,
    bool? isLastpage,
  }) {
    return PaginationState(
      isLoading: isLoading ?? this.isLoading,
      isLastpage: isLastpage ?? this.isLastpage,
    );
  }

  @override
  bool operator ==(covariant PaginationState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && other.isLastpage == isLastpage;
  }

  @override
  int get hashCode => isLoading.hashCode ^ isLastpage.hashCode;
}
