import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/service_locator.dart';

import '../../../core/domain/entities/media.dart';
import '../../../core/presentation/components/custom_app_bar.dart';
import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/presentation/components/vertical_listview_card.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/enums.dart';
import '../components/empty_watchlist_text.dart';
import '../controllers/watchlist_bloc/watchlist_bloc.dart';

class WatchlistView extends StatelessWidget {
  WatchlistView({super.key});

  final bloc = WatchlistBloc(sl(), sl(), sl(), sl());

  @override
  Widget build(BuildContext context) {
    _requestWhatchListItems();
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.watchlist),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return switch (state.status) {
              WatchlistRequestStatus.loading => const LoadingIndicator(),
              WatchlistRequestStatus.loaded => WatchlistWidget(
                items: state.items,
              ),
              WatchlistRequestStatus.empty => const EmptyWatchlistText(),
              WatchlistRequestStatus.error => ErrorScreen(
                onTryAgainPressed: () {
                  _requestWhatchListItems();
                },
              ),
            };
          },
        ),
      ),
    );
  }

  void _requestWhatchListItems() => bloc.add(GetWatchListItemsEvent());
}

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({super.key, required this.items});

  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      itemBuilder: (context, index) {
        return VerticalListViewCard(media: items[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
    );
  }
}
