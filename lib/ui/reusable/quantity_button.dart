import 'dart:async';
import 'package:assignment/bloc/product_action_bloc.dart';
import 'package:assignment/bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_action_event.dart';

enum ButtonOperation{
  add,
  remove
}

class QuantityButton extends StatefulWidget {

  final int initialQuantity;
  final int minimumValue;
  final Future<int>? Function(int) onQuantityChange;
  const QuantityButton(
      {Key? key,
        required this.initialQuantity,
        required this.onQuantityChange,
        this.minimumValue = 0
      })
      : super(key: key);

  @override
  _QuantityButtonState createState() => _QuantityButtonState(quantity: initialQuantity);
}

class _QuantityButtonState extends State<QuantityButton> {
  final StreamController<int> _quantityController = StreamController<int>.broadcast();

  int quantity;
  bool isSaving = false;
  _QuantityButtonState({required this.quantity});

  void changeQuantity(int newQuantity) async {
    isSaving = true;
    _quantityController.sink.add(newQuantity);

    newQuantity = await widget.onQuantityChange(newQuantity) ?? newQuantity;
    quantity = newQuantity;
    isSaving = false;
    _quantityController.sink.add(newQuantity);
    updateButton();
  }
  void updateButton() {
    final int amount = context.read<ProductsListBloc>().getTotalAmount();
    context.read<ProductsActionBloc>().add(DidChangeMenu(amount));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _quantityController.stream,
        builder: (context, snapshot) {
          return Container(
            decoration:  BoxDecoration(
                border: Border.all(
                    color: Colors.orange,
                    width: 2
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            width: 120,
            child:  quantity == widget.minimumValue
                ? addButton()
                : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _actionButton(ButtonOperation.remove),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.orange),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                  ),
                  _actionButton(ButtonOperation.add),
                ]),
          );
        }
    );
  }

  Widget addButton(){
    return InkWell(
      onTap: (){
        changeQuantity(1);
      },
      child: const SizedBox(
          height: 40,
          child: Center(child: Text('Add',
            style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w600),
          ))),
    );
  }

  Widget _actionButton(ButtonOperation operation){
    return SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
                color: Colors.black,
                onPressed: operation == ButtonOperation.remove
                    ? (isSaving || quantity < widget.minimumValue) // Remove Condition
                    ? null
                    : () => changeQuantity(quantity - 1)
                    : (isSaving) ? null : () => changeQuantity(quantity + 1), // Add Condition
                icon:  operation == ButtonOperation.remove
                    ? const Icon(Icons.remove, color: Colors.orange,)
                    :const Icon(Icons.add, color: Colors.orange,)
            ),
          );
  }

  @override
  void dispose() {
    _quantityController.close();
    super.dispose();
  }
}
