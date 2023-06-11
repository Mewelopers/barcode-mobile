import 'package:barcode_mobile/di/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
Future configureDependencies() async => await getIt.init();
