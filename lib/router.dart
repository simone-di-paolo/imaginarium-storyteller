
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/create_story_screen.dart';
import 'package:myapp/history_screen.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/library_screen.dart';
import 'package:myapp/scaffold_with_nav_bar.dart';
import 'package:myapp/settings_screen.dart';
import 'package:myapp/story_result_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'create',
                  builder: (BuildContext context, GoRouterState state) {
                    return const CreateStoryScreen();
                  },
                ),
                GoRoute(
                  path: 'story',
                  builder: (BuildContext context, GoRouterState state) {
                    return const StoryResultScreen();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/create',
              builder: (BuildContext context, GoRouterState state) {
                return const CreateStoryScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/library',
              builder: (BuildContext context, GoRouterState state) {
                return const LibraryScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/history',
              builder: (BuildContext context, GoRouterState state) {
                return const HistoryScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/settings',
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
