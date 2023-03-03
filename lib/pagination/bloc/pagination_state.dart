part of 'pagination_bloc.dart';

@immutable
class PaginationState {
  final Status status;
  final String message;
  final List<LeBazarData> products;
  final bool enabled;
  final int offset;
  final int limit;

  const PaginationState({
    this.status = Status.initial,
    this.message = "",
    this.products = const [],
    this.enabled = true,
    this.offset = 0,
    this.limit = 10,
  });

  PaginationState copyWith({
    Status? status,
    String? message,
    List<LeBazarData>? products,
    bool? hasData,
    int? offset,
  }) {
    return PaginationState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      enabled: hasData ?? this.enabled,
      offset: offset ?? this.offset,
    );
  }
}

enum Status { initial, loading, fail, success }
