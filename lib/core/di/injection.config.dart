// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../repositories/anime_detail_repo.dart' as _i6;
import '../../repositories/anime_repo.dart' as _i4;
import '../../screens/anime/bloc/anime_bloc.dart' as _i3;
import '../../screens/animeDetail/bloc/anime_detail_bloc.dart' as _i5;
import '../../services/anime_detail_service.dart' as _i7;
import '../../services/anime_service.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AnimeBloc>(
        () => _i3.AnimeBloc(animeRepository: gh<_i4.HelperAnimeRepository>()));
    gh.factory<_i5.AnimeDetailBloc>(() => _i5.AnimeDetailBloc(
        animeRepository: gh<_i6.HelperAnimeDetailRepository>()));
    gh.factory<_i7.HelperAnimeDetailService>(() => _i7.AnimeDetailService());
    gh.factory<_i8.HelperAnimeService>(() => _i8.AnimeService());
    gh.singleton<_i6.HelperAnimeDetailRepository>(
        _i6.AnimeDetailRepository(gh<_i7.HelperAnimeDetailService>()));
    gh.singleton<_i4.HelperAnimeRepository>(
        _i4.AnimeRepository(gh<_i8.HelperAnimeService>()));
    return this;
  }
}
