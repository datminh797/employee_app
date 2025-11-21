import 'package:employee_app/feature/module_global/presentation/bloc/language/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:toastification/toastification.dart';

import 'core/dependency_injection/injection.dart';
import 'core/route/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/size_config.dart';
import 'feature/module_location/presentation/presentation/location_bloc.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInitialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInitializer();
  }
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SizeConfig().init(context);
        return const AppRoot();
      },
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final LanguageBloc _languageBloc;
  late final LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = GetIt.instance<LanguageBloc>();
    _locationBloc = GetIt.instance<LocationBloc>()..add(GetLocation());
  }

  @override
  void dispose() {
    _locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>.value(value: _locationBloc),
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
      ],
      child: BlocBuilder<LanguageBloc, LanguageChanged>(
        builder: (context, localeState) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              // showPerformanceOverlay: true,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              theme: AppTheme.blueTheme,
              locale: localeState.locale,
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          );
        },
      ),
    );
  }
}
