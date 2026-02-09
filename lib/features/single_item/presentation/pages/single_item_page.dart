import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/report_sheet.dart';
import 'package:elonchi/features/single_item/presentation/widgets/charesteristics_section.dart';
import 'package:elonchi/features/single_item/presentation/widgets/pick_up_info_card.dart';
import 'package:elonchi/features/single_item/presentation/widgets/recomendations.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/action_buttons_section.dart';
import '../widgets/description_section.dart';
import '../widgets/floating_message_input.dart';
import '../widgets/location_section.dart';
import '../widgets/price_title_section.dart';
import '../widgets/product_image_header.dart';
import '../widgets/seller_section.dart';

class SingleItemPage extends StatefulWidget {
  const SingleItemPage({super.key});

  @override
  State<SingleItemPage> createState() => _SingleItemPageState();
}

class _SingleItemPageState extends State<SingleItemPage> {
  bool isFavorite = false;
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ProductImageHeader(
                isFavorite: isFavorite,
                currentImageIndex: currentImageIndex,
                onFavoriteToggle: () {},
                onBack: () => context.pop(),
                onInfo: () {
                  triggerBottomSheet(content: ReportSheet());
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PriceTitleSection(isFree: false, price: '400 000 сум', title: 'Atirgul yangi'),
                      const SizedBox(height: 8),
                      ActionButtonsSection(
                        onCall: () async {
                          final Uri phoneUri = Uri(scheme: 'tel', path: '+998777777777');
                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          } else {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text('Cannot place call')));
                          }
                        },
                        onMessage: () {
                          context.push(Routes.conversationScreen);
                        },
                      ),
                      const SizedBox(height: 8),
                      const DescriptionSection(
                        description: 'Состояние, причина продажи, комплектация, нюансы и другая полезная информация',
                      ),
                      const SizedBox(height: 16),

                      const CharacteristicsSection(characteristics: {'Состояние': 'Новый', 'Бренд': 'Loro Piano'}),
                      const SizedBox(height: 8),
                      const PickupInfoCard(),
                      const SizedBox(height: 8),
                      SellerSection(sellerName: 'Akbar', itemCount: 120, onTap: () {}),
                      const SizedBox(height: 8),
                      const LocationSection(
                        address: 'Toshkent shahar,Olmaliq tumani 24 a уй',
                        mapImagePath: 'assets/images/adress_inmap.png',
                      ),

                      RecomendationsSingle(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Align(alignment: Alignment.bottomCenter, child: FloatingMessageInput(showTextField: true)),
        ],
      ),
    );
  }
}
