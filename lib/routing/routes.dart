class Routes {
  Routes._();
  static const String homePage = '/home';
  static const String profilePage = '/profile';
  static const String eventsPage = '/events';
  static const String authPage = '/auth';

  static String eventDetail(String id) => '$homePage/event/$id';
  static const String eventDetailPath = 'event/:eventId'; // relative path inside homePage route
}