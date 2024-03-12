import 'package:anime_list/core/constants/app_constants.dart';

enum ServicePathEnum { anime, animdeDetail }

extension ServiceAdressPath on ServicePathEnum {
  String rawValue({String? id, String? page}) {
    switch (this) {
      case ServicePathEnum.anime:
        return '${ApplicationConstants.baseUrl}/top/anime?page=$page';

      case ServicePathEnum.animdeDetail:
        return '${ApplicationConstants.baseUrl}/anime/$id/characters';
    }
  }
}
