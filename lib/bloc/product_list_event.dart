part of 'product_list_bloc.dart';

abstract class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object> get props => [];
}

class LoadProductList extends ProductsListEvent {}

class ShowProductList extends ProductsListEvent {}
