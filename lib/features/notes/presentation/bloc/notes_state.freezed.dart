// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotesState()';
}


}

/// @nodoc
class $NotesStateCopyWith<$Res>  {
$NotesStateCopyWith(NotesState _, $Res Function(NotesState) __);
}


/// Adds pattern-matching-related methods to [NotesState].
extension NotesStatePatterns on NotesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotesInitial value)?  initial,TResult Function( NotesLoading value)?  loading,TResult Function( NotesEmpty value)?  empty,TResult Function( NotesLoaded value)?  loaded,TResult Function( NotesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotesInitial() when initial != null:
return initial(_that);case NotesLoading() when loading != null:
return loading(_that);case NotesEmpty() when empty != null:
return empty(_that);case NotesLoaded() when loaded != null:
return loaded(_that);case NotesError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotesInitial value)  initial,required TResult Function( NotesLoading value)  loading,required TResult Function( NotesEmpty value)  empty,required TResult Function( NotesLoaded value)  loaded,required TResult Function( NotesError value)  error,}){
final _that = this;
switch (_that) {
case NotesInitial():
return initial(_that);case NotesLoading():
return loading(_that);case NotesEmpty():
return empty(_that);case NotesLoaded():
return loaded(_that);case NotesError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotesInitial value)?  initial,TResult? Function( NotesLoading value)?  loading,TResult? Function( NotesEmpty value)?  empty,TResult? Function( NotesLoaded value)?  loaded,TResult? Function( NotesError value)?  error,}){
final _that = this;
switch (_that) {
case NotesInitial() when initial != null:
return initial(_that);case NotesLoading() when loading != null:
return loading(_that);case NotesEmpty() when empty != null:
return empty(_that);case NotesLoaded() when loaded != null:
return loaded(_that);case NotesError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  empty,TResult Function( List<Note> notes)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotesInitial() when initial != null:
return initial();case NotesLoading() when loading != null:
return loading();case NotesEmpty() when empty != null:
return empty();case NotesLoaded() when loaded != null:
return loaded(_that.notes);case NotesError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  empty,required TResult Function( List<Note> notes)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case NotesInitial():
return initial();case NotesLoading():
return loading();case NotesEmpty():
return empty();case NotesLoaded():
return loaded(_that.notes);case NotesError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( List<Note> notes)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case NotesInitial() when initial != null:
return initial();case NotesLoading() when loading != null:
return loading();case NotesEmpty() when empty != null:
return empty();case NotesLoaded() when loaded != null:
return loaded(_that.notes);case NotesError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NotesInitial implements NotesState {
  const NotesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotesState.initial()';
}


}




/// @nodoc


class NotesLoading implements NotesState {
  const NotesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotesState.loading()';
}


}




/// @nodoc


class NotesEmpty implements NotesState {
  const NotesEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotesState.empty()';
}


}




/// @nodoc


class NotesLoaded implements NotesState {
  const NotesLoaded(final  List<Note> notes): _notes = notes;
  

 final  List<Note> _notes;
 List<Note> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}


/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesLoadedCopyWith<NotesLoaded> get copyWith => _$NotesLoadedCopyWithImpl<NotesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesLoaded&&const DeepCollectionEquality().equals(other._notes, _notes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notes));

@override
String toString() {
  return 'NotesState.loaded(notes: $notes)';
}


}

/// @nodoc
abstract mixin class $NotesLoadedCopyWith<$Res> implements $NotesStateCopyWith<$Res> {
  factory $NotesLoadedCopyWith(NotesLoaded value, $Res Function(NotesLoaded) _then) = _$NotesLoadedCopyWithImpl;
@useResult
$Res call({
 List<Note> notes
});




}
/// @nodoc
class _$NotesLoadedCopyWithImpl<$Res>
    implements $NotesLoadedCopyWith<$Res> {
  _$NotesLoadedCopyWithImpl(this._self, this._then);

  final NotesLoaded _self;
  final $Res Function(NotesLoaded) _then;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notes = null,}) {
  return _then(NotesLoaded(
null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<Note>,
  ));
}


}

/// @nodoc


class NotesError implements NotesState {
  const NotesError(this.message);
  

 final  String message;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesErrorCopyWith<NotesError> get copyWith => _$NotesErrorCopyWithImpl<NotesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotesErrorCopyWith<$Res> implements $NotesStateCopyWith<$Res> {
  factory $NotesErrorCopyWith(NotesError value, $Res Function(NotesError) _then) = _$NotesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotesErrorCopyWithImpl<$Res>
    implements $NotesErrorCopyWith<$Res> {
  _$NotesErrorCopyWithImpl(this._self, this._then);

  final NotesError _self;
  final $Res Function(NotesError) _then;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
