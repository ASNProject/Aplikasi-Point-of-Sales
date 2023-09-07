import 'package:cash_whiz/blocs/list_product/list_product_event.dart';
import 'package:cash_whiz/blocs/list_product/list_product_state.dart';
import 'package:cash_whiz/core/repo/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final ListProductRepository _listProductRepository;

  ListProductBloc(this._listProductRepository)
      : super(ListProductLoadingState()) {
    on<LoadListProductEvent>((event, emit) async {
      emit(ListProductLoadingState());
      try {
        final listProducts = await _listProductRepository.getListProduct();
        emit(ListProductLoadedState(listProducts));
      } catch (e) {
        emit(ListProductErrorState(e.toString()));
      }
    });
  }
}
