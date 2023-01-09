import 'package:flutter/material.dart';

class ExpandableListView<T> extends StatelessWidget {
  const ExpandableListView({Key? key,
    required this.data,
    required this.noOfSections,
    required this.sectionTitle,
    required this.cellTitle,
    required this.getItemsSubMenu,
    this.itemHasSubMenu,
    this.buildCellForItem,
    this.expansionDidChange
  }) : super(key: key);

  final List<T> data;
  final int Function() noOfSections;
  final Widget Function(T) sectionTitle;
  final String Function(T) cellTitle;
  final List<T> Function(T) getItemsSubMenu;
  final bool Function(T)? itemHasSubMenu;
  final Widget Function(T)? buildCellForItem;
  final void Function(T, bool)? expansionDidChange;


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black12,
      ),
      itemCount: noOfSections(),
      itemBuilder: (BuildContext context, int index)
      => _buildList(data[index], context),
    );
  }

  Widget _buildList(T item, BuildContext context) {
    if (!itemHasSubMenu!(item)) {
      return _getCell(item);
    }
    getItemsSubMenu(item).map((e) {
      _buildList(e, context);
    }).toList();
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: sectionTitle(item),
        children: getItemsSubMenu(item).map((e) {
          return _buildList(e, context);
        }).toList(),
        onExpansionChanged: (value){
          if(expansionDidChange != null) {
            expansionDidChange!(item, value);
          }
        },
      ),
    );
  }

  Widget _getCell(T item) {
    if(buildCellForItem != null) {
      return buildCellForItem!(item);
    } else {
      return Builder(
        builder: (context) {
          return ListTile(
              onTap:() => debugPrint('Item clicked'),
              leading: const SizedBox(),
              title: Text(cellTitle(item))
          );
        }
    );
    }
  }
}
