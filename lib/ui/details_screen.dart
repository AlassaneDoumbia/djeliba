import 'package:djeliba/helpers/constants.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/ui/details/details_body.dart';
import 'package:djeliba/ui/view_models/details.view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'base.view.dart';

class DetailsView extends StatelessWidget {

  final String? id;
  const DetailsView({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, bool> values = {
      'Recuperer': false,
      'En cours': false,
      'Livré': false,
    };
    bool valueCheck = true;
    print("DetailsView $id");
    return BaseView<DetailsViewModel>(
      builder: (context, detailsVm, child) {
        Future infoF = detailsVm.info(context, id!);
        
        return Scaffold(
            appBar: AppBar(
              title:  Text("detailsDelivery".tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              backgroundColor: Colors.black38,
            ),
            backgroundColor: Colors.grey[200],
            body: FutureBuilder(
              future: infoF,
              builder: ((BuildContext context, snapshot){
                if (snapshot.hasError) {
                  return Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("error".tr()),
                      )
                  );
                }

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff52B69A)),
                        ),
                      ));
                }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data ==null){
                  return Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("noDelivery".tr())
                      )
                  );
                }else{
                  print("DetailsBody ::::::::::::::::::::::::::::::::::::::::");
                  print(snapshot.data);
                  return DetailsBody(delivery: snapshot.data,);
                }
              }),
            )
        );

      });
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
        Container(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Text(
            value,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
