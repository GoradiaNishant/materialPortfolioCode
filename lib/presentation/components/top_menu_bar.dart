import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_portfolio/base/constants.dart';
import 'package:material_portfolio/base/core_store/core_store_bloc.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import '../../utils/custom_segment_tab/widget.dart';

class TopMenuBar extends StatefulWidget {
  final CoreStore coreStore;
  const TopMenuBar({super.key, required this.coreStore});

  @override
  State<TopMenuBar> createState() => _TopMenuBarState();
}

class _TopMenuBarState extends State<TopMenuBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 750;

        return Align(
          alignment: isWide ? Alignment.topCenter : Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, -0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: isWide
                  ? _buildWideMenu(colorScheme)
                  : _buildPopupMenu(colorScheme),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWideMenu(ColorScheme colorScheme) {
    return Container(
      key: const ValueKey('wide'),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ValueListenableBuilder(
        valueListenable: widget.coreStore.screenIndex,
        builder: (context, value, child) {
          return CustomSlidingSegmentedControl<int>(
            initialValue: value,
            children: {
              0: bodyTextRegular('About Me',fontSize:24,color: (value == 0) ? colorScheme.onInverseSurface: colorScheme.onPrimaryContainer,),
              1: bodyTextRegular('Projects',fontSize:24,color: (value == 1) ? colorScheme.onInverseSurface: colorScheme.onPrimaryContainer,),
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            thumbDecoration: BoxDecoration(
              color: colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                ),
              ],
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
            onValueChanged: (index) {
              widget.coreStore.screenIndex.value = index;
            },
          );
        },
      ),
    );
  }

  Widget _buildPopupMenu(ColorScheme colorScheme) {
    return Container(
      key: const ValueKey('popup'),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.menu, color: colorScheme.onSurface),
        onSelected: (selectedItem) {
          final index = AppConst.menuItems.indexOf(selectedItem);
          widget.coreStore.screenIndex.value = index;
        },
        itemBuilder: (context) {
          return AppConst.menuItems.map((item) {
            final index = AppConst.menuItems.indexOf(item);
            final isSelected = widget.coreStore.screenIndex.value == index;
            return PopupMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}



