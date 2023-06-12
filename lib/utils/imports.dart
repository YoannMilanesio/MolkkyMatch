// Flutter - Dart
export 'package:flutter/material.dart'; // Material UI
export 'package:flutter/services.dart'; // Services
export 'dart:convert'; // Library Convert pour Json

// Packages
export 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Font Awesome Icons
export 'package:google_fonts/google_fonts.dart'; // Google Fonts
export 'package:flutter_blurhash/flutter_blurhash.dart'; // Blur Hash


// --- MY FILES

  // Routes
    export 'package:molkky_match/routes/routes.dart'; // Routes de l'app


  // -- Screens
    // Not Found
    export 'package:molkky_match/screens/_not_found/not_found_page.dart'; // Page 404 Error
    // Feedback
    export 'package:molkky_match/screens/feedback/feedback_page.dart'; // Page de retours utilisateurs
    // History
    export 'package:molkky_match/screens/history/history_page.dart'; // Page d'historique
    // Home
    export 'package:molkky_match/screens/home/home_page.dart'; // Page d'accueil
    // Players
    export 'package:molkky_match/screens/players/players_page.dart'; // Page des joueurs
    // Rules
    export 'package:molkky_match/screens/rules/rules_page.dart'; // Page des règles
    // Statistics
    export 'package:molkky_match/screens/statistics/statistics_page.dart'; // Page des statistiques


  // -- Utils
    // - Theme
    export 'package:molkky_match/utils/theme/app_styles.dart'; // Liste des styles textuels, boutons, ...
    export 'package:molkky_match/utils/theme/app_colors.dart'; // Liste des couleurs utilisées
    // - Tools
    export 'package:molkky_match/utils/tools/app_scaffold.dart'; // Scaffold de l'appli
    export 'package:molkky_match/utils/tools/appbar.dart'; // Scaffold de l'appli
    export 'package:molkky_match/utils/tools/drawer.dart'; // Scaffold de l'appli
    export 'package:molkky_match/utils/tools/fade_page_route.dart'; // Transition fade entres pages
    export 'package:molkky_match/utils/tools/home_scaffold.dart'; // Scaffold de l'appli
    // - Widgets
    export 'package:molkky_match/utils/widgets/hex_color.dart'; // Convert HexCode to Flutter Color