import 'package:djeliba/helpers/constants.dart';
import 'package:djeliba/locator.dart';
import 'package:djeliba/models/auth_data.model.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:djeliba/ui/widgets/container_body.dart';
import 'package:djeliba/ui/widgets/home/card_item.dart';
import 'package:djeliba/ui/widgets/home/header_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({
    Key? key,
  }) : super(key: key);

  String query = """
    query DeliveriesByDeliverer(\$first: Float) {
      deliveriesByDeliverer(first: \$first) {
        page {
          edges {
            node {
              _id,
            addressA,
            addressB,
            deliveryAmount,
            description,
            locationA,
            locationB,
            nameA,
            nameB,
            state,
            status,
            orderHasBeenPickedUp,
            createdAt
            }
          }
        }
      }
    }
  """;
  final List items = [
    'A faire',
    'Terminer'
  ];

  Widget getDeliveryList(String state){
    return Query(
        options: QueryOptions(
            document: gql(query),
            variables: const <String, dynamic>{"first": 5}),
        builder: (result, {fetchMore, refetch}) {
          // do something with result
          print("deliveries page ::::: ${result}");
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.hasException) {
            print("hasException ::::: ${result.exception.toString()}");
            // displaySnackBar("${tr('errorLogin')} : ${result.exception.toString()}", context);
          }

          if (result.data == null) {
            return const Center(
              child: Text("No deliveries found!"),
            );
          }
          // final deliveries = result.data!['deliveries'];
          final deliveries = result.data!['deliveriesByDeliverer'];
          print("deliveries ::::: $deliveries");
          final edges = deliveries["page"]["edges"];
          print("deliveries edges ::::: ${edges.length}");

          List<Delivery> delivers = Delivery.formatListe(edges);
          delivers = Delivery.filterListStatus(delivers, "PREPARATION");

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: delivers.length,
            itemBuilder: (context, index) {
              Delivery deli = delivers[index];

              return CardItem(index: deli.userId, path: "${deli.addressA} - ${deli.addressB}",
                  status: deli.userId, delivery: deli,);
            },
          );
        });

  }

  @override
  Widget build(BuildContext context) {
    final storageService = locator<SecureStorageService>();
    Future<AuthData> auth = storageService.getAuthData();

    final List<Widget> listDone = [ getDeliveryList("DONE")];
    final List<Widget> listOngoing = [
      // const CardItem(index: 1, status: "En cours"),
      // const CardItem(index: 2, status: "En cours"),
      // const CardItem(index: 3, status: "En cours"),
      // const CardItem(index: 4, status: "En cours"),
      // Column(
      //   children: [
      //
      //   ],
      // )
      getDeliveryList("PREPARATION")
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: auth,
            builder: ((BuildContext context, snapshot){
              if (snapshot.hasError) {
                return const HeaderTitle(title: "",);
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return  const HeaderTitle(title: "",);
              }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data ==null){
                return  const HeaderTitle(title: "",);
              }else{
                return HeaderTitle(title: "${snapshot.data?.lastName}");
              }
            }),
          ),
          // HeaderTitle(title: "${auth!.lastname}",),
          const SizedBox(height: 40.0),
          // ContainerBody(children: Steps(),),
          // const SizedBox(height: 40.0),
          ContainerBody(
              children: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      initiallyExpanded: index.isEven,
                      title: Text(items[index]),
                      maintainState: false,
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      expandedAlignment: Alignment.centerLeft,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      collapsedTextColor: Colors.black,
                      collapsedBackgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      children: index == 0 ? listOngoing : listDone,
                      onExpansionChanged: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "$index tile ${value ? "Expanded" : "Collapsed"}")));
                      },
                    ),
                  );
                },
              )
          )

        ],
      ),
    );
  }
}

