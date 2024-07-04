
class Delivery {
  final String userId;
  final int deliveryAmount;
  final String addressA;
  final String addressB;
  final String description;
  final String locationA;
  final String locationB;
  final String? nameA;
  final String? nameB;
  final String? phoneA;
  final String? phoneB;
  final String state;
  final String status;
  final String createdAt;

  const Delivery({
    required this.userId,
    required this.deliveryAmount,
    required this.addressA,
    required this.addressB,
    required this.description,
    required this.locationA,
    required this.locationB,
    required this.nameA,
    required this.nameB,
    required this.phoneA,
    required this.phoneB,
    required this.state,
    required this.status,
    required this.createdAt,
  });


  static List<Delivery> formatListe(List nodes){
    List<Delivery> deliveries = [];
    for(Map<String, dynamic> node in nodes){
      final data = node["node"];
      Delivery value = Delivery.fromJson(data);
      deliveries.add(value);
    }
    return deliveries;
  }

  static List<Delivery> filterListStatus(List<Delivery> list, String status){
    List<Delivery> deliveries = [];
    for(Delivery node in list){
      if(node.status == status){
        deliveries.add(node);
      }
    }
    return deliveries;
  }

  static List<Delivery> filterListState(List<Delivery> list, String state){
    List<Delivery> deliveries = [];
    for(Delivery node in list){
      if(node.state == state){
        deliveries.add(node);
      }
    }
    return deliveries;
  }

  factory Delivery.fromJson(Map<String, dynamic> data) {

    // final data = res;
    print('Delivery data ::::: $data');
    return Delivery(
      userId: data["_id"],
      deliveryAmount: data["deliveryAmount"],
      addressA: data["addressA"],
      addressB: data["addressB"],
      description: data["description"],
      locationA: data["locationA"].toString(),
      locationB: data["locationB"].toString(),
      nameA: data["nameA"],
      nameB: data["nameB"],
      phoneA: data["phoneA"].toString(),
      phoneB: data["phoneB"].toString(),
      state: data["state"].toString(),
      status: data["status"].toString(),
      createdAt: data["createdAt"].toString(),
    );
  }


}

