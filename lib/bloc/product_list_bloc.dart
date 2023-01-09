import 'package:assignment/model/dataModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_event.dart';
part 'product_list_states.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() : super(ProductsLoading()){
    _listener();
  }
  List<Menu> data = [];

  void _listener(){
    on<LoadProductList>((event, emit) {
      emit(ProductsLoading());
      dataList.forEach((key, value) {
          data.add(Menu.fromJson(key, value));
        });
      emit(ProductsLoaded(data));
    });
  }

  int getTotalAmount(){
    int total = 0;
    for(Menu menu in data) {
      total += menu.getTotalAmount();
    }
    return total;
  }
}