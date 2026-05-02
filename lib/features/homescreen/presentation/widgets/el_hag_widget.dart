import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/haj_handler_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/hajj_post_live_section.dart';
import 'package:quran/features/homescreen/presentation/widgets/live_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/mansak_constainer.dart';
import 'package:quran/features/homescreen/presentation/widgets/mansak_details.dart';

class ElHagWidget extends StatefulWidget {
  const ElHagWidget({super.key});

  @override
  State<ElHagWidget> createState() => _ElHagWidgetState();
}

class _ElHagWidgetState extends State<ElHagWidget> {
  int _selectIndex = 0;

  // +1 → new content enters from RIGHT (forward tap)
  // -1 → new content enters from LEFT  (backward tap)
  int _slideDirection = 1;

  // Changing this key is what triggers AnimatedSwitcher
  late ValueKey<int> _contentKey;

  @override
  void initState() {
    super.initState();
    _contentKey = ValueKey(_selectIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HajHandlerCubit>().getRitualData();
    });
  }

  void _onRitualTap(int index) {
    if (index == _selectIndex) return;
    setState(() {
      _slideDirection = index > _selectIndex ? 1 : -1;
      _selectIndex = index;
      _contentKey = ValueKey(_selectIndex);
    });
  }

  // ── Slide + Fade + subtle Scale ──────────────────────────────────────────
  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final isIncoming = animation.status != AnimationStatus.reverse;

    final slide = Tween<Offset>(
      begin: isIncoming
          ? Offset(_slideDirection * 0.18, 0) // new → enters from right
          : Offset(_slideDirection * -0.18, 0), // old → exits  to left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    final scale = Tween<double>(
      begin: isIncoming ? 0.97 : 1.0,
      end: isIncoming ? 1.0 : 0.97,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
      child: SlideTransition(
        position: slide,
        child: ScaleTransition(
          scale: scale,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          // ── Top spacing ────────────────────────────────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.hight * 0.01)),

          // ── Ritual tabs – FIXED, never animated ───────────────────────────
          SliverToBoxAdapter(
            child: BlocBuilder<HajHandlerCubit, HajHandlerState>(
              builder: (context, state) {
                if (state is HajHandlerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HajHandlerError) {
                  return Center(child: Text(state.message));
                }
                if (state is HajHandlerSuccess) {
                  return SizedBox(
                    width: ScreenSize.width,
                    height: ScreenSize.hight * 0.14,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.manasikList.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: ScreenSize.width * 0.02),
                      itemBuilder: (context, index) => MansakConstainer(
                        onTap: () => _onRitualTap(index),
                        title: state.manasikList[index].title,
                        image: state.manasikList[index].image,
                        isSelected: _selectIndex == index,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // ── Mid spacing ────────────────────────────────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.hight * 0.01)),

          // ── Animated details section ───────────────────────────────────────
          SliverToBoxAdapter(
            child: BlocBuilder<HajHandlerCubit, HajHandlerState>(
              builder: (context, state) {
                if (state is HajHandlerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HajHandlerError) {
                  return Center(child: Text(state.message));
                }
                if (state is HajHandlerSuccess) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 450),
                    reverseDuration: const Duration(milliseconds: 300),
                    transitionBuilder: _transitionBuilder,
                    layoutBuilder: (currentChild, previousChildren) => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    ),

                    child: MansakDetails(
                      key: _contentKey,
                      manasik: state.manasikList[_selectIndex],
                    ),
                  );
                } else if (state is HajHandlerInitial) {
                  return const Center(child: SizedBox());
                } else {
                  return const Center(child: Text('error'));
                }
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.hight * 0.02)),
          BlocBuilder<HajHandlerCubit, HajHandlerState>(
            builder: (context, state) {
              if (state is HajHandlerSuccess) {
                return SliverToBoxAdapter(child: const LiveMakkahBanner());
              } else if (state is HajHandlerError) {
                return SliverToBoxAdapter(child: Text(state.message));
              } else if (state is HajHandlerLoading) {
                return SliverToBoxAdapter(
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<HajHandlerCubit, HajHandlerState>(
            builder: (context, state) {
              if (state is HajHandlerSuccess) {
                return const SliverToBoxAdapter(child: HajjPostLiveSection());
              } else if (state is HajHandlerError) {
                return SliverToBoxAdapter(child: Text(state.message));
              } else if (state is HajHandlerLoading) {
                return SliverToBoxAdapter(
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
        ],
      ),
    );
  }
}
