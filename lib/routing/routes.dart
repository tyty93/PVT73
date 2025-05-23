/*
Make sure you push the full path.
Declare relative path strings here without leading /
 */
class Routes {
  Routes._();
  static const String homePage = '/home';
  static const String profilePage = '/profile';
  static const String eventsPage = '/events';
  static const String authPage = '/auth';
  static const String mapPage = '/map';
  static const String friendPage = '/friends';
  static const String create = 'create-event';

  // relative path under both homepage and eventpage due to how its under EventCard?
  //static String eventDetail(String id) => '$homePage/event/$id';
  static const String eventDetailPath = 'event/:eventId';

  static const String userInfoPath = 'user/:userId';
  static const String searchPath = 'search-users';
}