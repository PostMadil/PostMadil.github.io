import 'dart:developer';

import 'package:auto_ilitoi/src/actions/app_logic/index.dart';
import 'package:auto_ilitoi/src/container/index.dart';
import 'package:auto_ilitoi/src/models/index.dart';
import 'package:auto_ilitoi/src/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

Widget listOfOffers() {
  return OffersContainer(
    builder: (BuildContext context, List<Order> orders) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 6,
          crossAxisCount: 6,
        ),
        itemCount: (orders.length + 1) * 6,
        itemBuilder: (BuildContext context, int index) {
          if (index < 6) {
            switch (index) {
              case 0:
                {
                  return Container(
                    child: Center(
                      child: Text('Nume'),
                    ),
                  );
                }
              case 1:
                {
                  return Container(
                    child: Center(
                      child: Text('Car Plate'),
                    ),
                  );
                }
              case 2:
                {
                  return Container(
                    child: Center(
                      child: Text('Serie Sasiu'),
                    ),
                  );
                }
              case 3:
                {
                  return Container(
                    child: Center(
                      child: Text('Total'),
                    ),
                  );
                }
              case 4:
                {
                  return Container(
                    child: Center(
                      child: Text('Status'),
                    ),
                  );
                }
              case 5:
                {
                  return Container(
                    child: Center(
                      child: Text('Detalii'),
                    ),
                  );
                }
            }
          } else {
            Order currentOrder = orders[(index - 6) ~/ 6];
            Color unfinishedOrder = Colors.amber;
            if (isOrderValid(currentOrder)) {
              unfinishedOrder = Colors.blue;
            }
            switch (index % 6) {
              case 0:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: Center(
                      child: Text(currentOrder.name),
                    ),
                  );
                }
              case 1:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: Center(
                      child: Text(currentOrder.carPlate),
                    ),
                  );
                }
              case 2:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: Center(
                      child: SelectableText(currentOrder.chassisNumber),
                    ),
                  );
                }
              case 3:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: Center(
                      child: Text(currentOrder.total),
                    ),
                  );
                }
              case 4:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          currentOrder.paid ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                          currentOrder.paid ? Text('      Achitat') : Text(' Neachitat'),
                        ],
                      ),
                    ),
                  );
                }
              case 5:
                {
                  return Container(
                    color: index ~/ 6 % 2 == 1 ? unfinishedOrder : Colors.white60,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_outlined),
                      onPressed: () {
                        StoreProvider.of<AppState>(context).dispatch(SetSelectedOrder(currentOrder));
                        StoreProvider.of<AppState>(context).dispatch(const SetSelectedView(1));
                        log("I was pressed");
                      },
                    ),
                  );
                }
            }
          }
          return Text('');
        },
      );
    },
  );
}

bool isOrderValid(Order order) {
  int length = order.items.length;
  for (int i = 0; i < length; i++) {
    if (order.items[i].name == '' || order.items[i].name == null) {
      return false;
    }
    //Verify cod
    if (order.items[i].code == '' || order.items[i].code == null) {
      return false;
    }
    //Verify qty
    if (order.items[i].qty == '' || order.items[i].qty == null) {
      return false;
    } else {
      if (double.tryParse(order.items[i].qty!) == null) {
        return false;
      }
    }
    //Verify price
    if (order.items[i].price == '' || order.items[i].price == null) {
      return false;
    } else {
      if (double.tryParse(order.items[i].price!) == null) {
        return false;
      }
    }
  }
  return true;
}
