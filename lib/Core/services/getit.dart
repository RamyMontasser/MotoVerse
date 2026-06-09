import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/services/api_service.dart';
// import 'package:motoverse/Core/services/firestore_service.dart';
import 'package:motoverse/Core/services/image_picker_service.dart';
import 'package:motoverse/Core/services/location_service.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Features/auth/data/repo/auth_repo_imp.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
// import 'package:motoverse/Features/chat/data/repo/chat_repo_imp.dart';
// import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';
import 'package:motoverse/Features/home/data/repo/map_repo_imp.dart';
import 'package:motoverse/Features/home/domain/repo/map_repo.dart';
import 'package:motoverse/Features/map/data/repo/service_center_repo_imp.dart';
import 'package:motoverse/Features/map/domain/repo/service_center_repo.dart';
import 'package:motoverse/Features/community/data/repo/community_repo_imp.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/home/data/repo/home_repo_imp.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/history/data/repo/history_repo_imp.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';
import 'package:motoverse/Features/settings/data/repo/settings_repo.dart';
import 'package:motoverse/Features/settings/data/repo/settings_repo_impl.dart';
import 'package:motoverse/Core/services/socket_service.dart';
import 'package:motoverse/Features/socket_chat/domain/repo/chat_socket_repo.dart';
import 'package:motoverse/Features/socket_chat/data/repo/chat_socket_repo_impl.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';
import 'package:motoverse/Features/profile/data/repo/profile_car_repo_impl.dart';



final getIt = GetIt.instance;

void getitsetup() {
  BaseOptions options = BaseOptions(
    baseUrl:AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    },
  );

  getIt.registerSingleton<Dio>(Dio(options));

  //   Secure Storage
  getIt.registerSingleton<SecureStorage>(SecureStorage());

  
  getIt.registerSingleton<NetworkService>(
      ApiService(dio: getIt<Dio>(), secureStorage: getIt<SecureStorage>()));


  // getIt.registerSingleton<FirestoreService>(
  //     FirestoreService());

  //   Authintication
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      networkService: getIt<NetworkService>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  //   Map
  getIt.registerSingleton<MapRepo>(
    MapRepoImp(locationService: LocationService(), networkService: getIt<NetworkService>(),
),
  );

  getIt.registerSingleton<ServiceCenterRepo>(
    ServiceCenterRepoImp(
      networkService: getIt<NetworkService>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  getIt.registerSingleton<CommunityRepo>(
    CommunityRepoImp(networkService: getIt<NetworkService>()),
  );

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImp(networkService: getIt<NetworkService>()),
  );
  
  getIt.registerSingleton<HistoryRepo>(
    HistoryRepoImp(networkService: getIt<NetworkService>()),
  );

  getIt.registerSingleton<SettingsRepo>(
    SettingsRepoImpl(networkService:  getIt<NetworkService>() ),
  );

  getIt.registerSingleton<ProfileCarRepo>(
    ProfileCarRepoImpl(networkService: getIt<NetworkService>()),
  );
  
  // getIt.registerSingleton<ChatRepo>(
  //   ChatRepoImpl(firestoreService: getIt<FirestoreService>()),
  // );

  getIt.registerSingleton<SocketService>(SocketService());
  getIt.registerSingleton<ChatSocketRepository>(
    ChatSocketRepositoryImpl(
      socketService: getIt<SocketService>(),
      networkService: getIt<NetworkService>(),
    ),
  );



  //  Image Picker

  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
}
