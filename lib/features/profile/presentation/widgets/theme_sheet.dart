import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';

class ThemeSheet extends StatelessWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Тема оформления',
          style: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text('Выберите, как будет выглядеть приложение'),
        const SizedBox(height: 20),
        WScaleAnimation(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.color.base200,
              border: Border.all(width: 0.5, color: context.color.stroke),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.background),
                  child: Image.asset(PIcons.lighthemeImg),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Светлая", style: TextStyle(fontSize: 16, color: context.color.textStrong)),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: 240,
                      child: Text(
                        'Светлый интерфейс с максимальной читаемостью',
                        style: TextStyle(fontSize: 12, color: context.color.textSoft),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        WScaleAnimation(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.color.base200,
              border: Border.all(width: 0.5, color: context.color.stroke),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  padding: const EdgeInsets.all(3),
                  height: 48,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.background),
                  child: Image.asset(PIcons.darkThemeImg),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Тёмная", style: TextStyle(fontSize: 16, color: context.color.textStrong)),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: 240,
                      child: Text(
                        'Светлый интерфейс с максимальной читаемостью',
                        style: TextStyle(fontSize: 12, color: context.color.textSoft),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
