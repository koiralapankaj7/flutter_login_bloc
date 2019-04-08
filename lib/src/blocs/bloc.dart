import 'dart:async';
import 'validation_mixin.dart';
import 'package:rxdart/rxdart.dart';

// In dart we cannot apply a mixin to a class without first extending it.
// By be this is fixed in new version of dart as i did not see any error.
// If this error arise at some point of time then first extend some class before using as mixin.
// Object is the base class for all the classes available in dart so you can extends object before using mixin.
// E.G, class Bloc extends Object with ValidationMixin
// You can simply extends validation_mixin class as well. Then it will not be treated as mixin.
// This approach will be counted as inheritance.
// E.G, class Bloc extends ValidationMixin

class Bloc extends Object with ValidationMixin {
  /*
   * We know that email and password will always be string so that we make controller generic.
   * If we dont have any idea what type of values run through stram controller then we dont make
   * stream controller genrric i.e StreamController controller = new StreamController();
   * Stream controller by default is single subscription stream so we cannot listen more than once
   */

  // 1. Single subscription stream
  // final StreamController<String> _emailController = StreamController<String>();
  // final StreamController<String> _passwordController =
  //     StreamController<String>();

  // 2. Multi subscription stream
  // final StreamController<String> _emailController =
  //     StreamController<String>.broadcast();
  // final StreamController<String> _passwordController =
  //     StreamController<String>.broadcast();

  // 3. RxDart BehaviorSubject
  // BehaviorSubject by default is broadcast controller
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  // Add data to stream (Similar to setter function)
  //===========================================================================

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Retrieve data from stream (Similar to getter function)
  //===========================================================================

  // Before retriving value it must be pass through transformer for validation.
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  // Using RxDart function
  // Email and password is stream whereas e and p is value of email and password.
  // As there is no work of the values right know i declare e and p.
  Stream<bool> get submitValidation =>
      Observable.combineLatest2(email, password, (String e, String p) => true);

  // Button click calback function
  submit() {
    final String validEmail = _emailController.value;
    final String validPassword = _passwordController.value;
    print("Email is $validEmail and Password is $validPassword");
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

/*
 * 1. Single Global Instance
 * ==========================================================================================
 * This is the first way we can apply bloc in our project.
 * This method is known as Single Global Instance
 * All over the project only one instance of the BLOC will be created and same instance will be
 * shared by all classes. Data accuracy will be increased by this approach as every class will get
 * and send similar data which results uniformation.
 * For large project this might not be a wise choice as we might have to deal with different types of
 * data/streams with more than single bloc class.
 * Less code less control over data
 * With this approach we can access block instance just by importing this class.
 */

// ****** We are using Scoped Instances for this project so i am commenting this.
// final Bloc bloc = Bloc();

/*
 * 2. Scoped Instances
 * ==========================================================================================
 * We can create multiple instance of bloc as per requirement in different pages.
 * Also using inheriated widget we can pass instance of bloc through all its child widgets and classes.
 * This bring more power.
 * More code more control over data
 */
