import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/mesto_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  setupLocator();
  FlutterError.onError =
      (details) => getIt<Talker>().handle(details.exception, details.stack);

  Bloc.observer = TalkerBlocObserver(
      talker: talker, settings: const TalkerBlocLoggerSettings(enabled: true));
  runApp(const MestoApp());
}
