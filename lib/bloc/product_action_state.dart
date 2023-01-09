import 'package:equatable/equatable.dart';

import '../model/dataModel.dart';

abstract class ProductActionState extends Equatable {
  const ProductActionState();

  @override
  List<Object?> get props => [];
}


class ProductsSelectionDidChange extends ProductActionState {
  final List<Menu> selectedProducts;
  const ProductsSelectionDidChange(this.selectedProducts);
}

class TotalAmountUpdate extends ProductActionState {
  final int totalAmount;
  const TotalAmountUpdate(this.totalAmount);
}