import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pageination/pagination/data/leBazarData.dart';

import '../api/news_api.dart';

part 'pagination_event.dart';

part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final _api = NewsApi();

  PaginationBloc() : super(const PaginationState()) {
    on<PaginationInitEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        offset: 0,
        hasData: true,
      ));
      try {
        emit(
          state.copyWith(
            status: Status.success,
            products: await _api.news(
              search: "",
              offset: state.offset,
              limit: state.limit,
            ),
          ),
        );
      } catch (e) {}
    });
    on<PaginationSearchEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        offset: 0,
        hasData: true,
      ));
      try {
        emit(
          state.copyWith(
            status: Status.success,
            products: await _api.news(
              search: event.text,
              offset: state.offset,
              limit: state.limit,
            ),
          ),
        );
      } catch (e) {}
    });
    on<PaginationNextEvent>((event, emit) async {
      if (!state.enabled) return;

      emit(state.copyWith(
        status: Status.loading,
        offset: state.offset + state.limit,
      ));
      try {
        final products = await _api.news(
          search: event.text,
          offset: state.offset,
          limit: state.limit,
        );
        emit(
          state.copyWith(
            status: Status.success,
            hasData: products.isNotEmpty,
            products: [...state.products, ...products],
          ),
        );
      } catch (e) {}
    });
  }
}
