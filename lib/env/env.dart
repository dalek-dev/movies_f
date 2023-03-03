import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.development')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKy = _Env.apiKy;

  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static final apiBaseKy = _Env.apiBaseKy;

  @EnviedField(varName: 'API_AUTH', obfuscate: true)
  static final apiAuthKy = _Env.apiAuthKy;

  @EnviedField(varName: 'CONTENT_TYPE', obfuscate: true)
  static final ctType = _Env.ctType;
}
