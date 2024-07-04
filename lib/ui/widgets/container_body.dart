import 'package:flutter/material.dart';

class ContainerBody extends StatefulWidget {
  Widget children;
  // List<Widget> children;

  ContainerBody({ Key? key, required this.children}) : super(key: key);

  @override
  _ContainerBodyState createState() => _ContainerBodyState(children: children);
}

class _ContainerBodyState extends State<ContainerBody> {

  Widget children;
  _ContainerBodyState({required this.children});
  // late List<Widget> children;
  // final List<Map<String, dynamic>> items = List.generate(
  //     10,
  //         (index) => {
  //       'id': index,
  //       'title': 'Item $index',
  //       'description':
  //       'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  //       'isExpanded': false
  //     });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical:  height * 0.04, horizontal:width * 0.03),
        child: children,
        // ListView(
        //   children: children,
        // ),
      ),
    );
  }


}