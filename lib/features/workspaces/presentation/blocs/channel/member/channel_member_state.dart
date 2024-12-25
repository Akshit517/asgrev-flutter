part of 'channel_member_bloc.dart';

sealed class ChannelMemberState extends Equatable {
  const ChannelMemberState();
  
  @override
  List<Object> get props => [];
}

final class ChannelMemberInitial extends ChannelMemberState {}

final class ChannelMemberLoading extends ChannelMemberState {}

final class ChannelMemberLoaded extends ChannelMemberState {
  final List<ChannelMember> members;
  const ChannelMemberLoaded({required this.members});
} 

final class ChannelMemberError extends ChannelMemberState {
  final String message;
  const ChannelMemberError({required this.message});
}

final class ChannelMemberSuccess extends ChannelMemberState {
  final String message;
  const ChannelMemberSuccess({required this.message});
}