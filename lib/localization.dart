
class KeepLocalization {

  late String locale;

  KeepLocalization({required this.locale});

  String? get updateText =>
      locale == 'uk' ? 'останнє оновлення' : 'last update time';

  String? get currentPosition =>
      locale == 'uk' ? 'Поточна локація' : 'Current position';

  String? get positions =>
      locale == 'uk' ? 'Локації' : 'Locations';

  String? get settings =>
      locale == 'uk' ? 'Налаштування' : 'Settings';

  String? get languages =>
      locale == 'uk' ? 'Мови' : 'Languages';

  String? get automaticLanguage =>
      locale == 'uk' ? 'Вибери стиль' : 'Choose style';

  String? get languageMenu =>
      locale == 'uk' ? 'Виберіть мову додатку' : 'Choose your app language';

  String? get englishLang =>
      locale == 'uk' ? 'Англійська' : 'English';

  String? get ukrainianLang =>
      locale == 'uk' ? 'Українська' : 'Ukrainian';

  String? get darkMode =>
      locale == 'uk' ? 'Темна тема' : 'Dark mode';

  String? get lightMode =>
      locale == 'uk' ? 'Світла тема' : 'Light mode';

  String? get aboutApp =>
      locale == 'uk' ? 'Про програму' : 'About';

  String? get aboutAppDetails =>
      locale == 'uk' ? 'Додаткові відомості' : 'Learn more about';

  String? get hourlyWeather =>
      locale == 'uk' ? 'ПРОГНОЗ ПО ГОДИНАХ' : 'HOURLY WEATHER';

  String? get daysWeather =>
      locale == 'uk' ? 'ПРОГНОЗ НА ДЕНЬ' : 'DAYS WEATHER';

  String? get today =>
      locale == 'uk' ? 'Сьогодні' : 'Today';

  String? get locations =>
      locale == 'uk' ? 'Локації' : 'Locations';
}