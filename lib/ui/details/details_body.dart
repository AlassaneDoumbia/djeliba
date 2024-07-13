import 'package:djeliba/helpers/constants.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/ui/widgets/container_body.dart';
import 'package:djeliba/ui/widgets/home/card_item.dart';
import 'package:djeliba/ui/widgets/home/header_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class DetailsBody extends StatelessWidget {
  Delivery delivery;
  DetailsBody({
    Key? key, required this.delivery,
  }) : super(key: key);

  String percentage = "0%";
  Map<String, bool> values = {
    "recover".tr(): false,
    'ongoing'.tr(): false,
    'delivered'.tr(): false,
  };

  // state = NOT_DELIVERED | DELIVERED | CANCELED
  // status = UNREACHABLE | UNAVAILABLE | PREPARATION | PENDING | MORE | DISPATCH

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:  Text(
                "Nº ${delivery!.userId}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                width: double.maxFinite,
                height: 275,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black87,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    __itemValue(
                      title: "pointA".tr(),
                      value: "${delivery.addressA} / ${delivery.phoneA}",
                    ),
                    __itemValue(
                      title: "pointB".tr(),
                      value: delivery.orderHasBeenPickedUp ? "${delivery.addressB} / ${delivery.phoneB}" : "",
                    ),
                    __itemValue(
                      title: "amount".tr(),
                      value: "${delivery.deliveryAmount}",
                    ),
                    __itemValue(
                      title: "total".tr(),
                      value: "${delivery.deliveryAmount}",
                    ),
                    __itemValue(
                      title: "details".tr(),
                      value: delivery.description,
                    ),
                    // __itemValue(
                    //   title: "Point A:",
                    //   value: "Sacre coeur 3 /accessoirs dakar - 77 410 45 95 ",
                    // ),
                    // __itemValue(
                    //   title: "Point B:",
                    //   value: "ouakam / +221 78 131 52 80 ",
                    // ),
                    // __itemValue(
                    //   title: "Commande:",
                    //   value: "800 ",
                    // ),
                    // __itemValue(
                    //   title: "Total:",
                    //   value: "800 ",
                    // ),
                    // __itemValue(
                    //   title: "Detail :",
                    //   value: "dsjsdjdsjdjk ",
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                width: double.maxFinite,
                // height: 250,
                // padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black87,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        //SizedBox
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                          child:Icon(
                            Icons.cached_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ), //SizedBox
                        Text(
                          'state'.tr(),
                          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                        ), //Text
                        const SizedBox(width: 10), //Checkbox
                      ], //<Widget>[]
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        width: widthSize * 0.8,
                        lineHeight: 14.0,
                        percent: 0.5,
                        center: const Text(
                          "50.0%",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        backgroundColor: Colors.grey,
                        progressColor: kPrimaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("cancel".tr()),
                            activeColor: Colors.green,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: delivery.orderHasBeenPickedUp,
                            onChanged: (value) => print(value)

                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("ongoing".tr()),
                            activeColor: Colors.green,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: false,
                            onChanged: (value) => print(value)

                          ),
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("ongoing".tr()),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.green,
                            value: false,
                            onChanged: (value) => print(value)

                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("delivered".tr()),
                            activeColor: Colors.green,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: false,
                            onChanged: (value) =>  print(value)

                          ),
                        ),
                        
                      ],
                    ),
                    Row(
  //                                             "cancel": "Annuler",
  // "notdelivered": "Non Livré",
  // "unreachable": "Non Joingnable",
  // "unavailable": "Non disponible",
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("notdelivered".tr()),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.green,
                            value: false,
                            onChanged: (value) => print(value)

                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("recover".tr()),
                            activeColor: Colors.green,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: false,
                            onChanged: (value) => print(value)

                          ),
                        ),
                        
                      ],
                    ),
                    // Column(
                    //   children: values.keys.map(
                    //         (String key) {
                    //       return CheckboxListTile(
                    //         controlAffinity: ListTileControlAffinity.leading,
                    //         activeColor: Colors.green,
                    //         value: values[key],
                    //         title: Text(key),
                    //         onChanged: (value) => (value) => print(value),
                    //         // onChanged: (value) => detailsVm.onChangedvalueCheck(value!),
                    //       );
                    //     },
                    //   ).toList(),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'path'.tr(),
                      style: const TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class __itemValue extends StatelessWidget {
  final String title;
  final String value;
  const __itemValue({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

