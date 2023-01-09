import 'package:assignment/bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import '../bloc/product_action_bloc.dart';
import '../bloc/product_action_state.dart';
import '../model/dataModel.dart';
import 'reusable/expandable_list_view.dart';
import 'menu_cell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>  {
  ProductsListBloc productsListBloc = ProductsListBloc();
  @override
  void initState() {
    productsListBloc.add(LoadProductList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assignment'),
        ),
        body: BlocProvider(
          create: (_) => ProductsActionBloc(),
          child:  BlocProvider(
          create: (_) => productsListBloc,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<ProductsListBloc, ProductsListState>(
                builder: (context, state) {
                  print(state);
                  if(state is ProductsLoaded) {
                    List<Menu> data = state.productsData;
                    return ExpandableListView<Menu>(
                      data: data,
                      noOfSections: (){
                        return data.length;
                      },
                      sectionTitle: (item){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500 ),
                            ),
                            Text('${item.subMenu.length}')
                          ],
                        );
                      },
                      cellTitle: (item) {
                        return item.name;
                      },
                      getItemsSubMenu: (item){
                        return item.subMenu;
                      },
                      itemHasSubMenu: (item) {
                        return item.subMenu.isNotEmpty;
                      },
                      buildCellForItem: (item){
                        return MenuCell(data: item);
                      },
                    );
                  }
                  else {
                    return Container();
                  }
                },
              ),
               placeOrderButton(),
            ],
          ),
        ),
)
    );
  }

  Widget placeOrderButton(){

    return BlocBuilder<ProductsActionBloc, ProductActionState>(
      builder: (context, state) {
        if(state is TotalAmountUpdate && state.totalAmount > 0){
          print(state.totalAmount);
          //TODO: Figure out why this isn't rebuilding
          return Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.only(right: 5,left: 5),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration:   BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange),
            child: Row(
              children: [
                Expanded(flex: 1, child: Container(),),
                Expanded(flex: 2, child: _textWidget('Place Order'),),
                Expanded(flex: 1, child: _textWidget('${state.totalAmount}'),),
              ],
            ),
          );
        }
        else {
          return Container();
        }

      },
    );
  }

  Widget _textWidget(String text){
    return Text(text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600
      ),
    );
  }
}
