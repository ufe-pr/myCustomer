import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked/stacked.dart';

class CustomPartialBuild<T extends BaseViewModel> extends HookViewModelWidget<T> {

  final Function(BuildContext, T) builder;

  CustomPartialBuild({Key key, @required this.builder, reactive: false}) : super(key: key, reactive: reactive);

  @override
  Widget buildViewModelWidget(BuildContext context, T viewModel) => this.builder(context, viewModel);

}