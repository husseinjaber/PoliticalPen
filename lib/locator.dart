import 'package:get_it/get_it.dart';
import 'DynamicLinkk/DynamicLinkService.dart';

GetIt locator = GetIt.instance;
void setupLocator()
{
  locator.registerLazySingleton(() => DynamicLinkService());

}