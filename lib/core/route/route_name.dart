enum RouteName {
  login('/log-in', 'login'),
  signUp('/sign-up', 'signUp'),

  home('/', 'home'),
  feed('/feed', 'feed'),
  asigned('/asigned', 'asigned'),
  profile('/profile', 'profile'),

  error('/error', 'error');

  final String path;
  final String name;

  const RouteName(this.path, this.name);

  String pathWithParams(Map<String, String> params) {
    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll(':$key', value);
    });
    return result;
  }

  bool get requiresAuth {
    switch (this) {
      case RouteName.signUp:
      case RouteName.login:
      case RouteName.error:
        return false;
      default:
        return true;
    }
  }

  bool get showBottomNav {
    switch (this) {
      case RouteName.home:
      case RouteName.feed:
      case RouteName.asigned:
      case RouteName.profile:
        return true;
      default:
        return false;
    }
  }

  int? get bottomNavIndex {
    switch (this) {
      case RouteName.home:
        return 0;
      case RouteName.feed:
        return 1;
      case RouteName.asigned:
        return 2;
      case RouteName.profile:
        return 3;
      default:
        return null;
    }
  }
}
