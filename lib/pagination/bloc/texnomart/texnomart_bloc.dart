import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pageination/pagination/data/texnomartData.dart';

import '../../api/news_api.dart';

part 'texnomart_event.dart';

part 'texnomart_state.dart';

class TexnomartBloc extends Bloc<TexnomartEvent, TexnomartState> {
  final _api = NewsApi();

  TexnomartBloc() : super(TexnomartState()) {
    on<TexnomartInitEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        currentPage: 0,
        hasData: true,
      ));
      final data = await _api.texnomartData();
      try {
        emit(
          state.copyWith(
              status: Status.success,
              products: data.items,
              currentPage: data.meta.currentPage,
              totalPage: data.meta.pageCount),
        );
      } catch (e) {}
    });

    on<TexnomartSearchEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        currentPage: 0,
        hasData: true,
      ));
      final data = await _api.texnomartData(search: event.text);
      try {
        emit(
          state.copyWith(
              status: Status.success,
              products: data.items,
              currentPage: data.meta.currentPage,
              totalPage: data.meta.pageCount),
        );
      } catch (e) {}
    });

    on<TexnomartNextEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        currentPage: state.currentPage+1,
        hasData: true,
      ));
      final data = await _api.texnomartData(search: event.text,current: state.currentPage);
      try {
        emit(
          state.copyWith(
              status: Status.success,
              products: [...state.products, ...data.items],
              currentPage: data.meta.currentPage,
              totalPage: data.meta.pageCount),
        );
      } catch (e) {}
    });
  }
}
