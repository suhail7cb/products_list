import 'package:assignment/ui/reusable/quantity_button.dart';
import 'package:flutter/material.dart';
import '../model/dataModel.dart';

class MenuCell extends StatelessWidget {
  const MenuCell({Key? key, required this.data}) : super(key: key);

  final Menu data;
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Column(
            children: [
              Container(
                color: Colors.grey.withOpacity(0.15),
                child: ListTile(
                  // onTap:() => debugPrint('Item clicked'),
                  title: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 30),
                    child: Builder(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text('\$ ${data.price}',
                                    style: const TextStyle(fontSize: 15, color: Colors.black45)))
                          ],
                        );
                      }
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: QuantityButton(
                      initialQuantity: data.totalAdded,
                      onQuantityChange: (int value) {
                        data.totalAdded = value;
                        return Future.value(data.totalAdded);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                height: 1,
                width: double.maxFinite,
                color: Colors.grey.withOpacity(0.25),
              )
            ],
          );
        }
    );
  }
}
