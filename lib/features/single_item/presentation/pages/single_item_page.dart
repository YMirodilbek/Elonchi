import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:elonchi/features/report/presentation/bloc/bloc/report_bloc.dart';
import 'package:elonchi/features/report/presentation/pages/report_sheet.dart';
import 'package:elonchi/features/single_item/presentation/blocs/bloc/single_bloc.dart';
import 'package:elonchi/features/single_item/presentation/widgets/action_buttons_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/charesteristics_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/description_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/floating_message_input.dart';
import 'package:elonchi/features/single_item/presentation/widgets/location_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/pick_up_info_card.dart';
import 'package:elonchi/features/single_item/presentation/widgets/price_title_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/product_image_header.dart';
import 'package:elonchi/features/single_item/presentation/widgets/seller_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/shimmers.dart';
import 'package:elonchi/features/single_item/presentation/widgets/watch_sheet.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleItemPage extends StatefulWidget {
  final int itemId;
  const SingleItemPage({super.key, required this.itemId});

  @override
  State<SingleItemPage> createState() => _SingleItemPageState();
}

class _SingleItemPageState extends State<SingleItemPage> {
  int currentImageIndex = 0;

  late final SingleBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SingleBloc>();
    bloc.add(GetSingleItemEvent(widget.itemId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleBloc, SingleState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.color.background,
          body: state.status == ApiStatus.loading
              ? SingleShimmer()
              : Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        ProductImageHeader(
                          isFavorite: state.product?.iLike ?? false,
                          currentImageIndex: currentImageIndex,
                          images: state.product?.image?.map((e) => e.image ?? '').toList() ?? [],
                          onFavoriteToggle: () {
                            if (state.likeApiStatus == ApiStatus.loading) return;
                            bloc.add(ToggleFavoriteEvent(widget.itemId));
                          },
                          onBack: () => context.pop(),
                          onInfo: () {
                            triggerBottomSheet(
                              content: BlocProvider(
                                create: (context) => sl<ReportBloc>(),
                                child: ReportSheet(productId: widget.itemId),
                              ),
                            );
                          },
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                PriceTitleSection(
                                  onTap: () async {
                                    final result = await triggerBottomSheet<bool>(
                                      content: WatchSheet(iswatching: state.product?.isWatching ?? false),
                                    );
                                    if (result != null) {
                                      bloc.add(WatchProductEvent(widget.itemId));
                                    }
                                  },
                                  isWatching: state.product?.isWatching ?? false,
                                  isFree: state.product?.price == null || state.product?.price == '0',
                                  price: '${state.product?.price ?? 'N/A'} ${state.product?.moneyType ?? ''}',
                                  title: state.product?.title ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                ActionButtonsSection(
                                  onCall: () async {
                                    final Uri phoneUri = Uri(scheme: 'tel', path: state.product?.phoneNumber ?? '');
                                    if (await canLaunchUrl(phoneUri)) {
                                      await launchUrl(phoneUri);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(const SnackBar(content: Text('Cannot place call')));
                                    }
                                  },
                                  onMessage: () {
                                    context.push(
                                      Routes.conversationScreen,
                                      extra: ConversationRequest(
                                        type: SmsType.buyer,
                                        userName: state.product?.contactName ?? '',
                                        message: '',
                                        product: ProductMessage(
                                          id: widget.itemId,
                                          title: state.product?.title,
                                          price: state.product?.price,
                                          moneyType: state.product?.moneyType,
                                          image: state.product?.image?.isNotEmpty == true
                                              ? state.product?.image!.first.image
                                              : null,
                                        ),
                                        userId: state.product?.user ?? 0,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                                DescriptionSection(description: state.product?.description ?? 'No description'),
                                const SizedBox(height: 16),
                                CharacteristicsSection(
                                  characteristics: {'Состояние': state.product?.condition ?? 'N/A', '': ""},
                                ),
                                const SizedBox(height: 8),
                                const PickupInfoCard(),
                                const SizedBox(height: 8),
                                SellerSection(
                                  sellerName: state.product?.contactName ?? 'Unknown',
                                  itemCount: state.product?.viewsCount ?? 0,
                                  onTap: () {},
                                ),
                                const SizedBox(height: 8),
                                LocationSection(
                                  address: state.product?.address ?? 'N/A',
                                  mapImagePath: 'assets/images/adress_inmap.png',
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Рекомендуем',
                                  style: TextStyle(
                                    color: context.color.textStrong,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                        if (state.relatedProducts.isNotEmpty)
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              delegate: SliverChildBuilderDelegate((context, index) {
                                final product = state.relatedProducts[index];
                                final imageUrl = (product.image?.isNotEmpty ?? false)
                                    ? product.image!.first.image ?? "assets/images/item_1.png"
                                    : "assets/images/item_1.png";
                                return ProductItem(
                                  itemId: product.id ?? 0,
                                  onLikedTap: () {
                                    if (state.likeRelatedProductsApiStatus == ApiStatus.loading) return;
                                    bloc.add(ToggleLikeRecomendedProduct(product.id ?? 0));
                                  },
                                  productImagePath: imageUrl,
                                  title: product.price ?? "N/A",
                                  liked: product.iLike ?? false,
                                  description: product.title ?? "N/A",
                                );
                              }, childCount: state.relatedProducts.length),
                            ),
                          ),
                        SliverToBoxAdapter(child: const SizedBox(height: 80)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingMessageInput(
                        onSendMessage: (value) {
                          context.push(
                            Routes.conversationScreen,
                            extra: ConversationRequest(
                              type: SmsType.buyer,
                              userName: state.product?.contactName ?? '',
                              message: value,
                              product: ProductMessage(
                                id: widget.itemId,
                                title: state.product?.title,
                                price: state.product?.price,
                                moneyType: state.product?.moneyType,
                                image: state.product?.image?.isNotEmpty == true
                                    ? state.product?.image!.first.image
                                    : null,
                              ),
                              userId: state.product?.user ?? 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// single => 
// - set loading status to true 
// - create room 
// - get Id of the room and send the last message to the server 



// all messages, 
// -get Id of the conversation and get 
// 

//Get all messages 
//Handle Single
//Handle sending form data request 
//Handle the UI with images,
//Handle the Product information 
//Handle the pagination and so on, with dates 
// Handle deletion in single and in overall screen 
//
