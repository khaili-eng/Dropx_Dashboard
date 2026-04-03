import 'package:equatable/equatable.dart';
import 'package:maadati/features/advertesment/data/model/adv_model.dart';

abstract class AdvState extends Equatable{
  const AdvState();
  @override
  List<Object?>get props=>[];
}
class AdvInitial extends AdvState{}
class AdvLoading extends AdvState{}
class AdvSuccess extends AdvState{
  final AdvModel advModel;
  final String message;
  const AdvSuccess({
    required this.advModel,
    required this.message
});
  @override
  List<Object?> get props =>[advModel,message];
}
class AdvError extends AdvState{
  final String error;
  const AdvError(this.error);
  @override
  List<Object?> get props => [ error];
}
//get all adv success
class AdvLoaded extends AdvState{
  final List<AdvModel>advs;
  const AdvLoaded(this.advs);
  @override
  List<Object?>get props=>[advs];
}
//state for update adv
class UpdateAdvLoading extends AdvState{}
class AdvUpdateSuccess extends AdvState{
  final AdvModel ad;
  final String message;
  const AdvUpdateSuccess({
    required this.ad,
   required this.message
}
      );
}
class AdvUpdateError extends AdvState{
  final String error;
  const AdvUpdateError(this.error);
}