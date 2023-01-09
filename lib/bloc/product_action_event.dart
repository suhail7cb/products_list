
import 'package:equatable/equatable.dart';

abstract class ProductsActionEvent extends Equatable {
  const ProductsActionEvent();

  @override
  List<Object> get props => [];
}

class DidChangeMenu extends ProductsActionEvent {
  final int totalAmount;
  const DidChangeMenu(this.totalAmount);
}

class DidRemoveProduct extends ProductsActionEvent {}