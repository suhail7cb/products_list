part of 'product_list_bloc.dart';

abstract class ProductsListState extends Equatable {
  const ProductsListState();
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsListState {}

class ProductsLoaded extends ProductsListState {
  final List<Menu> productsData;
  const ProductsLoaded(this.productsData);
}


class ProductListingError extends ProductsListState {
  final String? message;
  const ProductListingError(this.message);
}