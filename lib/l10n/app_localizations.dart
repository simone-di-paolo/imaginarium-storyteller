import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @createYourStory.
  ///
  /// In en, this message translates to:
  /// **'Customize Your Story'**
  String get createYourStory;

  /// No description provided for @makeItPersonal.
  ///
  /// In en, this message translates to:
  /// **'Make it personal for your little one'**
  String get makeItPersonal;

  /// No description provided for @characterDetails.
  ///
  /// In en, this message translates to:
  /// **'Character Details'**
  String get characterDetails;

  /// No description provided for @childsName.
  ///
  /// In en, this message translates to:
  /// **'Child\'s Name'**
  String get childsName;

  /// No description provided for @enterChildsName.
  ///
  /// In en, this message translates to:
  /// **'Enter your child\'s name'**
  String get enterChildsName;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @howOldAreThey.
  ///
  /// In en, this message translates to:
  /// **'How old are they?'**
  String get howOldAreThey;

  /// No description provided for @favoriteAnimal.
  ///
  /// In en, this message translates to:
  /// **'Favorite Animal'**
  String get favoriteAnimal;

  /// No description provided for @whatsTheirFavoriteAnimal.
  ///
  /// In en, this message translates to:
  /// **'What\'s their favorite animal?'**
  String get whatsTheirFavoriteAnimal;

  /// No description provided for @storySetting.
  ///
  /// In en, this message translates to:
  /// **'Story Setting'**
  String get storySetting;

  /// No description provided for @whereShouldTheStoryTakePlace.
  ///
  /// In en, this message translates to:
  /// **'Where should the story take place?'**
  String get whereShouldTheStoryTakePlace;

  /// No description provided for @magicalForest.
  ///
  /// In en, this message translates to:
  /// **'e.g., magical forest, space station...'**
  String get magicalForest;

  /// No description provided for @reviewAndGenerate.
  ///
  /// In en, this message translates to:
  /// **'Review & Generate'**
  String get reviewAndGenerate;

  /// No description provided for @storyPreview.
  ///
  /// In en, this message translates to:
  /// **'Story Preview'**
  String get storyPreview;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category:'**
  String get category;

  /// No description provided for @mainCharacter.
  ///
  /// In en, this message translates to:
  /// **'Main Character:'**
  String get mainCharacter;

  /// No description provided for @companion.
  ///
  /// In en, this message translates to:
  /// **'Companion:'**
  String get companion;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting:'**
  String get setting;

  /// No description provided for @aiMagicReady.
  ///
  /// In en, this message translates to:
  /// **'AI Magic Ready!'**
  String get aiMagicReady;

  /// No description provided for @weWillCreateAUniqueStory.
  ///
  /// In en, this message translates to:
  /// **'We\'ll create a unique story with beautiful backgrounds just for you.'**
  String get weWillCreateAUniqueStory;

  /// No description provided for @createNewStory.
  ///
  /// In en, this message translates to:
  /// **'Create New Story'**
  String get createNewStory;

  /// No description provided for @chooseACategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a Story Category'**
  String get chooseACategory;

  /// No description provided for @whatKindOfAdventure.
  ///
  /// In en, this message translates to:
  /// **'What kind of adventure should we create?'**
  String get whatKindOfAdventure;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @generateStoryButton.
  ///
  /// In en, this message translates to:
  /// **'Generate Story'**
  String get generateStoryButton;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category first.'**
  String get pleaseSelectCategory;

  /// No description provided for @storyInclude.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what your story will include'**
  String get storyInclude;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
