
import 'package:djeliba/locator.dart';
import 'package:djeliba/ui/view_models/base.vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Function(T)? dispose;
  final Function(T)? initState;
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const BaseView({
    Key? key,
    this.dispose,
    this.initState,
    required this.builder,
  }) : super(key: key);

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  final T model = locator<T>();

  @override
  void initState() {
    if (widget.initState != null) widget.initState!(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.dispose != null) widget.dispose!(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // model.setBuildContext(context);
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}