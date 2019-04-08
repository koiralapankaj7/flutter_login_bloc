//This class is used to provide instance of block for its child widgets. That is why we named provider.
// This class will extends inherated based class

import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  // Instance of bloc for provider
  final Bloc bloc = Bloc();

  // Provider should have the ability to accept the child widget that will show underneeth itself.
  // We need to define provider constructor function for that and take some argument from that
  // constructor function. After that we have to pass it to super class of InheritedWidget or base
  // class of InheritedWidget.
  // If we do not define constructor and pass through arguments then argumets do not automatically
  // forwarded to super class.
  Provider({Key key, Widget child}) : super(key: key, child: child);

  // Default parameter of the updateShouldNotify is updateShouldNotify(InheritedWidget oldWidget).
  // But we dont care parameter at this time so we will replaced it by under score (_) which means
  // We dont care. _ is valid variable in dart.
  @override
  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    // All the widgets in flutter has their own context.
    // Child context is aware about all the other context that stands above it. That means child widget
    // context is aware about its all parent widget context and this is possible through BuildContext.
    // of(BuildContext context) => This context inside parameter is of current widget context.
    // context.inheritFromWidgetOfExactType(Provider) =>  What does this means is, hey current widget context
    // please go up through all the parent widget context until you find widget named Provider. (Search in widget
    // tree upwards until you find Provider widget).
    // as Provider => Dart does not know exactly which widget context.inheritFromWidgetOfExactType(Provider)
    // this line will return so it will return InheritedWidget. By using as Provider we are saying that,
    // hey dart what wever you get from this line it will be Provider widget,
    // so we are defining as Provider in the code.
    // And using that provider we are retriving the bloc property.
    // This way we can access bloc property from any child widget does not matter how nested widget tree is.
    // We have to simply call this method by Provider.of(context).
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
