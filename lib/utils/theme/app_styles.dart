import 'package:molkky_match/utils/imports.dart';

class AppStyles {
  // Accueil - Titre App
  static const TextStyle homeTitleTextStyle = TextStyle(
      fontSize: 50,
      color: AppColors.whiteColor,
      fontFamily: "RailsBroken"
  );

  static TextStyle homeTitleOutlinedTextStyle = const TextStyle(
      fontSize: 40,
      color: AppColors.whiteColor,
      fontFamily: "RailsBroken",
  );

  // Accueil - Citation
  static const TextStyle homeQuoteTextStyle = TextStyle(
    fontSize: 20,
    color: AppColors.whiteColor,
  );

  // Titre de page
  static const TextStyle pageTitleStyle = TextStyle(
    fontSize: 33,
    color: AppColors.whiteColor,
  );

  // Sous-titre de page
  static const TextStyle pageSubtitleStyle = TextStyle(
    fontSize: 28,
    color: AppColors.whiteColor,
  );

  // Sous-titre de page
  static const TextStyle drawerTextStyle = TextStyle(
    fontSize: 24,
    color: AppColors.whiteColor,
  );

  // Texte de page
  static const TextStyle pageTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.whiteColor,
  );

  // Primary Button
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    elevation: 5,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    )
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
    fontSize: 22,
    color: AppColors.whiteColor,
  );

  // Secondary Button
  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.whiteColor,
      elevation: 5,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      )
  );

  static TextStyle secondaryButtonTextStyle = const TextStyle(
    fontSize: 22,
    color: AppColors.primaryColor,
  );

}