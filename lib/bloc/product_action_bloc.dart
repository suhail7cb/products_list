import 'package:assignment/bloc/product_action_event.dart';
import 'package:assignment/bloc/product_action_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsActionBloc extends Bloc<ProductsActionEvent, ProductActionState> {
  ProductsActionBloc() : super(const ProductsSelectionDidChange([])) {
    _listener();
  }

  void _listener(){
    on<DidChangeMenu>((event, emit) {
      emit(TotalAmountUpdate(event.totalAmount));
    });

    on<DidRemoveProduct>((event, emit) {
      emit(const TotalAmountUpdate(10));
    });
  }
}