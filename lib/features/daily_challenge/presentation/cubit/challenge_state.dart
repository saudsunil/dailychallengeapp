import 'package:flutter/material.dart';

import '../../domain/entities/challenge.dart';
import '../../domain/entities/streak.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_state.freezed.dart';

@freezed
class ChallengeState with _$ChallengeState{
   const factory ChallengeState.initial()= _Initial;

   const factory ChallengeState.loading()= _Loading;

   const factory ChallengeState.loaded({
     required Challenge challenge,
     required Streak streak,
   })= _Loaded;

   const factory ChallengeState.error(String message)= _Error;
}
