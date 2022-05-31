import 'package:awesome_app/src/features/authentication/presentation/appbar_shape.dart';
import 'package:awesome_app/src/features/authentication/presentation/login_controller.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_app/src/utils/async_value_ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>(debugLabel: 'formLogin');
  late AssetImage appbarImage;

  @override
  void initState() {
    super.initState();
    appbarImage = const AssetImage(AssetConstants.appbarImg);
  }

  @override
  void didChangeDependencies() {
    precacheImage(appbarImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginScreenControllerProvider,
        (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(loginScreenControllerProvider);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context, state),
    ));
  }

  Widget _buildBody(BuildContext context, AsyncValue<void> state) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          height: AppConstants.getSize(context).height * 0.40,
          child: Container(
            color: Colors.transparent,
            height: AppConstants.getSize(context).height * 0.40,
            width: AppConstants.getSize(context).width,
            child: ClipPath(
              clipper: AppbarShape(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: appbarImage,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Text(
                  "Awesome App",
                  style: AppConstants.getTheme(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                )),
              ),
            ),
          ),
        ),
        Positioned(
          top: AppConstants.getSize(context).height * 0.40,
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 50,
            color: Colors.transparent,
            padding: const EdgeInsets.all(AppConstants.paddingSize),
            child: Text(
              "Login to your account",
              style: AppConstants.getTheme(context).textTheme.headline5,
            ),
          ),
        ),
        Positioned(
          top: AppConstants.getSize(context).height * 0.40 +
              (AppConstants.paddingSize * 2),
          bottom: 0,
          right: 0,
          left: 0,
          child: Form(
            key: _formKeyLogin,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(AppConstants.paddingSize,
                  AppConstants.paddingSize, AppConstants.paddingSize, 0),
              shrinkWrap: true,
              children: [
                TextFormField(
                  key: const Key('username'),
                  cursorColor: ColorConstants.onPrimary,
                  decoration: const InputDecoration(labelText: "Username"),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter any username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstants.paddingSize / 2),
                TextFormField(
                  key: const Key('password'),
                  cursorColor: ColorConstants.onPrimary,
                  decoration: const InputDecoration(labelText: "Password"),
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter any password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstants.paddingSize / 2),
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(loginScreenControllerProvider.notifier)
                            .loginAnonymously();
                      },
                      child: Text(
                        'Login as Guest',
                        style:
                            AppConstants.getTheme(context).textTheme.bodyMedium,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKeyLogin.currentState!.validate()) {
                            await ref
                                .read(loginScreenControllerProvider.notifier)
                                .login(
                                    _email.text.trim(), _password.text.trim());
                          }
                        },
                        child: Text(
                          "Login",
                          style: AppConstants.getTheme(context)
                              .textTheme
                              .bodyLarge,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
