// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:barcode_mobile/di/register_module.dart' as _i7;
import 'package:barcode_mobile/services/auth_service.dart' as _i3;
import 'package:barcode_mobile/services/list_of_lists_service.dart' as _i5;
import 'package:barcode_mobile/services/product_list_service.dart' as _i6;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singletonAsync<_i3.AuthService>(() {
      final i = _i3.AuthService();
      return i.tryRefreshPreviousSession().then((_) => i);
    });
    await gh.singletonAsync<_i4.Dio>(
      () => registerModule.dio,
      preResolve: true,
    );
    gh.factory<_i5.ListOfListsService>(
        () => _i5.ListOfListsService(gh<_i4.Dio>()));
    gh.factory<_i6.ProductListService>(
        () => _i6.ProductListService(gh<_i4.Dio>()));
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
