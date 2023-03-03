part of 'texnomart_bloc.dart';

class TexnomartState {
  final Status status;
  final String message;
  final List<Item> products;
  final bool enabled;
  final int currentPage;
  final int totalPage;

   TexnomartState(
      {this.status = Status.initial,
      this.message = "",
      this.products = const [],
      this.enabled = true,
      this.currentPage = 0,
      this.totalPage = 0});

  TexnomartState copyWith({
    Status? status,
    String? message,
    List<Item>? products,
    bool? hasData,
    int? currentPage,
    int? totalPage,
  }) {
    return TexnomartState(
        status: status ?? this.status,
        message: message ?? this.message,
        products: products ?? this.products,
        enabled: hasData ?? this.enabled,
        currentPage: currentPage ?? this.currentPage,
        totalPage: totalPage ?? this.totalPage);
  }
}

enum Status { initial, loading, fail, success }
