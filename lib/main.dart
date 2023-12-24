import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/pages/account/password_screen.dart';
import 'package:thu_vien_sach/pages/account/profile_screen.dart';
import 'package:thu_vien_sach/pages/admin/banner/banner_detail_screen.dart';
import 'package:thu_vien_sach/pages/admin/banner/banner_table.dart';
import 'package:thu_vien_sach/pages/admin/books/admin_book_detail_screen.dart';
import 'package:thu_vien_sach/pages/admin/books/book_table.dart';
import 'package:thu_vien_sach/pages/admin/category/category_detail_screen.dart';
import 'package:thu_vien_sach/pages/admin/category/category_table.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_screen.dart';
import 'package:thu_vien_sach/pages/admin/user/user_table.dart';
import 'package:thu_vien_sach/pages/app/main_screen.dart';
import 'package:thu_vien_sach/pages/detail_book/book_reader.dart';
import 'package:thu_vien_sach/pages/detail_book/book_screen.dart';
import 'package:thu_vien_sach/pages/auth/login_page.dart';
import 'package:thu_vien_sach/pages/auth/register_page.dart';
import 'package:thu_vien_sach/pages/detail_book/comment_provider.dart';
import 'package:thu_vien_sach/pages/detail_book/comments_screen.dart';
import 'package:thu_vien_sach/pages/labels/book_label_screen.dart';
import 'package:thu_vien_sach/pages/library/library_provider.dart';
import 'package:thu_vien_sach/pages/splash/splash_screen.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';
import 'package:thu_vien_sach/providers/book_provider.dart';
import 'package:thu_vien_sach/providers/category_provider.dart';
import 'package:thu_vien_sach/services/auth_service.dart';
import 'package:thu_vien_sach/services/banner_service.dart';
import 'package:thu_vien_sach/services/book_service.dart';
import 'package:thu_vien_sach/services/category_service.dart';
import 'package:thu_vien_sach/services/comment_service.dart';
import 'package:thu_vien_sach/services/local_service.dart';
import 'package:thu_vien_sach/services/user_service.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPref = await SharedPreferences.getInstance();

  final AuthService authService = AuthService();
  final BookService bookService = BookService();
  final CategoryService categoryService = CategoryService();
  final BannerService bannerService = BannerService();
  final UserService userService = UserService();
  final CommentService commentService = CommentService();
  final LocalService localService = LocalService(sharedPref);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AuthProvider(authService, localService)),
      ChangeNotifierProvider(
        create: (_) =>
            HomeProvider(bookService, categoryService, bannerService),
      ),
      ChangeNotifierProvider(
        create: (_) => BookProvider(bookService),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryProvider(categoryService)..init(),
      ),
      ChangeNotifierProvider(
        create: (_) => DashBoardProvider(
            bookService, categoryService, userService, bannerService),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (_) => LibraryProvider(bookService, localService),
      ),
      ChangeNotifierProvider(
        create: (_) => CommnetProvider(commentService, localService),
      ),
    ],
    child: MaterialApp(
      title: 'Thu Vien Sach', // used by the OS task switcher
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => const MainScreen(),
        '/book': (context) {
          final book = ModalRoute.of(context)!.settings.arguments as Book;
          return BookDetailScreen(book: book);
        },
        '/comment': (context) {
          final book = ModalRoute.of(context)!.settings.arguments as Book;
          return CommentScreen(book: book);
        },
        '/label': (context) {
          final label = ModalRoute.of(context)!.settings.arguments as Category;
          return BookLabelScreen(label: label);
        },
        '/reader': (context) {
          final book = ModalRoute.of(context)!.settings.arguments as Book;
          return BookReaderScreen(book: book);
        },
        '/change-password': (context) => PasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/admin-books': (context) => const BookTable(),
        '/admin-book-detail': (context) {
          final book = ModalRoute.of(context)!.settings.arguments as Book?;
          return AdminBookDetainScreen(
            book: book,
          );
        },
        '/admin-categories': (context) => const CategoryTable(),
        '/admin-category-detail': (context) {
          final category =
              ModalRoute.of(context)!.settings.arguments as Category?;
          return CategoryDetailScreen(category: category);
        },
        '/admin-users': (context) => const UserTable(),
        '/admin-banners': (context) => const BannnerTable(),
        '/admin-banner-detail': (context) {
          final banner = ModalRoute.of(context)!.settings.arguments as Banner?;
          return BannerDetailScreen(banner: banner);
        },
      },
    ),
  ));
}
