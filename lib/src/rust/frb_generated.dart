// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.7.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {}

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.7.0';

  @override
  int get rustContentHash => 861948925;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'bytebeam_flutter',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  BytebeamCredentials crateApiBytebeamSdkAutoAccessorGetCredentials(
      {required BytebeamSdk that});

  void crateApiBytebeamSdkAutoAccessorSetCredentials(
      {required BytebeamSdk that, required BytebeamCredentials credentials});

  Future<Uint8List> crateApiBytebeamSdkDownloadUpdate(
      {required BytebeamSdk that, required AvailableUpdate update});

  Future<AvailableUpdate?> crateApiBytebeamSdkFetchAvailableUpdate(
      {required BytebeamSdk that});

  Future<BytebeamSdk> crateApiBytebeamSdkParse({required String creds});

  Future<void> crateApiBytebeamSdkUploadMessageFfi(
      {required BytebeamSdk that, required StreamMessageFfi message});

  Future<void> crateApiBytebeamSdkUploadMessagesBatchFfi(
      {required BytebeamSdk that, required List<StreamMessageFfi> messages});

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_BytebeamSdk;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_BytebeamSdk;

  CrossPlatformFinalizerArg get rust_arc_decrement_strong_count_BytebeamSdkPtr;
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  BytebeamCredentials crateApiBytebeamSdkAutoAccessorGetCredentials(
      {required BytebeamSdk that}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 1)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_bytebeam_credentials,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiBytebeamSdkAutoAccessorGetCredentialsConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkAutoAccessorGetCredentialsConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_auto_accessor_get_credentials",
        argNames: ["that"],
      );

  @override
  void crateApiBytebeamSdkAutoAccessorSetCredentials(
      {required BytebeamSdk that, required BytebeamCredentials credentials}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        sse_encode_bytebeam_credentials(credentials, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 2)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiBytebeamSdkAutoAccessorSetCredentialsConstMeta,
      argValues: [that, credentials],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkAutoAccessorSetCredentialsConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_auto_accessor_set_credentials",
        argNames: ["that", "credentials"],
      );

  @override
  Future<Uint8List> crateApiBytebeamSdkDownloadUpdate(
      {required BytebeamSdk that, required AvailableUpdate update}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        sse_encode_box_autoadd_available_update(update, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_prim_u_8_strict,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiBytebeamSdkDownloadUpdateConstMeta,
      argValues: [that, update],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkDownloadUpdateConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_download_update",
        argNames: ["that", "update"],
      );

  @override
  Future<AvailableUpdate?> crateApiBytebeamSdkFetchAvailableUpdate(
      {required BytebeamSdk that}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 4, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_opt_box_autoadd_available_update,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiBytebeamSdkFetchAvailableUpdateConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkFetchAvailableUpdateConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_fetch_available_update",
        argNames: ["that"],
      );

  @override
  Future<BytebeamSdk> crateApiBytebeamSdkParse({required String creds}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(creds, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 5, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData:
            sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiBytebeamSdkParseConstMeta,
      argValues: [creds],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkParseConstMeta => const TaskConstMeta(
        debugName: "BytebeamSdk_parse",
        argNames: ["creds"],
      );

  @override
  Future<void> crateApiBytebeamSdkUploadMessageFfi(
      {required BytebeamSdk that, required StreamMessageFfi message}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        sse_encode_box_autoadd_stream_message_ffi(message, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 6, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiBytebeamSdkUploadMessageFfiConstMeta,
      argValues: [that, message],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkUploadMessageFfiConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_upload_message_ffi",
        argNames: ["that", "message"],
      );

  @override
  Future<void> crateApiBytebeamSdkUploadMessagesBatchFfi(
      {required BytebeamSdk that, required List<StreamMessageFfi> messages}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
            that, serializer);
        sse_encode_list_stream_message_ffi(messages, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 7, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_String,
      ),
      constMeta: kCrateApiBytebeamSdkUploadMessagesBatchFfiConstMeta,
      argValues: [that, messages],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiBytebeamSdkUploadMessagesBatchFfiConstMeta =>
      const TaskConstMeta(
        debugName: "BytebeamSdk_upload_messages_batch_ffi",
        argNames: ["that", "messages"],
      );

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_BytebeamSdk => wire
          .rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_BytebeamSdk => wire
          .rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk;

  @protected
  BytebeamSdk
      dco_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  BytebeamSdk
      dco_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  BytebeamSdk
      dco_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Map<String, FieldValue> dco_decode_Map_String_field_value(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return Map.fromEntries(dco_decode_list_record_string_field_value(raw)
        .map((e) => MapEntry(e.$1, e.$2)));
  }

  @protected
  BytebeamSdk
      dco_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  AvailableUpdate dco_decode_available_update(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 5)
      throw Exception('unexpected arr length: expect 5 but see ${arr.length}');
    return AvailableUpdate(
      actionId: dco_decode_String(arr[0]),
      url: dco_decode_String(arr[1]),
      version: dco_decode_String(arr[2]),
      checksum: dco_decode_String(arr[3]),
      size: dco_decode_u_32(arr[4]),
    );
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  AvailableUpdate dco_decode_box_autoadd_available_update(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_available_update(raw);
  }

  @protected
  StreamMessageFfi dco_decode_box_autoadd_stream_message_ffi(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_stream_message_ffi(raw);
  }

  @protected
  BytebeamCertificates dco_decode_bytebeam_certificates(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return BytebeamCertificates(
      caCertificate: dco_decode_String(arr[0]),
      deviceCertificate: dco_decode_String(arr[1]),
      devicePrivateKey: dco_decode_String(arr[2]),
    );
  }

  @protected
  BytebeamCredentials dco_decode_bytebeam_credentials(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return BytebeamCredentials(
      projectId: dco_decode_String(arr[0]),
      deviceId: dco_decode_String(arr[1]),
      apiUrl: dco_decode_String(arr[2]),
      authentication: dco_decode_bytebeam_certificates(arr[3]),
    );
  }

  @protected
  double dco_decode_f_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as double;
  }

  @protected
  FieldValue dco_decode_field_value(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    switch (raw[0]) {
      case 0:
        return FieldValue_Null();
      case 1:
        return FieldValue_String(
          dco_decode_String(raw[1]),
        );
      case 2:
        return FieldValue_Int(
          dco_decode_i_64(raw[1]),
        );
      case 3:
        return FieldValue_Bool(
          dco_decode_bool(raw[1]),
        );
      case 4:
        return FieldValue_Float(
          dco_decode_f_64(raw[1]),
        );
      case 5:
        return FieldValue_Array(
          dco_decode_list_field_value(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  @protected
  PlatformInt64 dco_decode_i_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeI64(raw);
  }

  @protected
  List<FieldValue> dco_decode_list_field_value(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_field_value).toList();
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  List<(String, FieldValue)> dco_decode_list_record_string_field_value(
      dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>)
        .map(dco_decode_record_string_field_value)
        .toList();
  }

  @protected
  List<StreamMessageFfi> dco_decode_list_stream_message_ffi(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_stream_message_ffi).toList();
  }

  @protected
  AvailableUpdate? dco_decode_opt_box_autoadd_available_update(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw == null ? null : dco_decode_box_autoadd_available_update(raw);
  }

  @protected
  (String, FieldValue) dco_decode_record_string_field_value(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2) {
      throw Exception('Expected 2 elements, got ${arr.length}');
    }
    return (
      dco_decode_String(arr[0]),
      dco_decode_field_value(arr[1]),
    );
  }

  @protected
  StreamMessageFfi dco_decode_stream_message_ffi(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return StreamMessageFfi(
      stream: dco_decode_String(arr[0]),
      sequence: dco_decode_u_32(arr[1]),
      timestamp: dco_decode_u_64(arr[2]),
      fields: dco_decode_Map_String_field_value(arr[3]),
    );
  }

  @protected
  int dco_decode_u_32(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  BigInt dco_decode_u_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  BigInt dco_decode_usize(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  BytebeamSdk
      sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  BytebeamSdk
      sse_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  BytebeamSdk
      sse_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Map<String, FieldValue> sse_decode_Map_String_field_value(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_record_string_field_value(deserializer);
    return Map.fromEntries(inner.map((e) => MapEntry(e.$1, e.$2)));
  }

  @protected
  BytebeamSdk
      sse_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return BytebeamSdkImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  AvailableUpdate sse_decode_available_update(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_actionId = sse_decode_String(deserializer);
    var var_url = sse_decode_String(deserializer);
    var var_version = sse_decode_String(deserializer);
    var var_checksum = sse_decode_String(deserializer);
    var var_size = sse_decode_u_32(deserializer);
    return AvailableUpdate(
        actionId: var_actionId,
        url: var_url,
        version: var_version,
        checksum: var_checksum,
        size: var_size);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  AvailableUpdate sse_decode_box_autoadd_available_update(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_available_update(deserializer));
  }

  @protected
  StreamMessageFfi sse_decode_box_autoadd_stream_message_ffi(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_stream_message_ffi(deserializer));
  }

  @protected
  BytebeamCertificates sse_decode_bytebeam_certificates(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_caCertificate = sse_decode_String(deserializer);
    var var_deviceCertificate = sse_decode_String(deserializer);
    var var_devicePrivateKey = sse_decode_String(deserializer);
    return BytebeamCertificates(
        caCertificate: var_caCertificate,
        deviceCertificate: var_deviceCertificate,
        devicePrivateKey: var_devicePrivateKey);
  }

  @protected
  BytebeamCredentials sse_decode_bytebeam_credentials(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_projectId = sse_decode_String(deserializer);
    var var_deviceId = sse_decode_String(deserializer);
    var var_apiUrl = sse_decode_String(deserializer);
    var var_authentication = sse_decode_bytebeam_certificates(deserializer);
    return BytebeamCredentials(
        projectId: var_projectId,
        deviceId: var_deviceId,
        apiUrl: var_apiUrl,
        authentication: var_authentication);
  }

  @protected
  double sse_decode_f_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getFloat64();
  }

  @protected
  FieldValue sse_decode_field_value(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var tag_ = sse_decode_i_32(deserializer);
    switch (tag_) {
      case 0:
        return FieldValue_Null();
      case 1:
        var var_field0 = sse_decode_String(deserializer);
        return FieldValue_String(var_field0);
      case 2:
        var var_field0 = sse_decode_i_64(deserializer);
        return FieldValue_Int(var_field0);
      case 3:
        var var_field0 = sse_decode_bool(deserializer);
        return FieldValue_Bool(var_field0);
      case 4:
        var var_field0 = sse_decode_f_64(deserializer);
        return FieldValue_Float(var_field0);
      case 5:
        var var_field0 = sse_decode_list_field_value(deserializer);
        return FieldValue_Array(var_field0);
      default:
        throw UnimplementedError('');
    }
  }

  @protected
  PlatformInt64 sse_decode_i_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getPlatformInt64();
  }

  @protected
  List<FieldValue> sse_decode_list_field_value(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <FieldValue>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_field_value(deserializer));
    }
    return ans_;
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  List<(String, FieldValue)> sse_decode_list_record_string_field_value(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <(String, FieldValue)>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_record_string_field_value(deserializer));
    }
    return ans_;
  }

  @protected
  List<StreamMessageFfi> sse_decode_list_stream_message_ffi(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <StreamMessageFfi>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_stream_message_ffi(deserializer));
    }
    return ans_;
  }

  @protected
  AvailableUpdate? sse_decode_opt_box_autoadd_available_update(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    if (sse_decode_bool(deserializer)) {
      return (sse_decode_box_autoadd_available_update(deserializer));
    } else {
      return null;
    }
  }

  @protected
  (String, FieldValue) sse_decode_record_string_field_value(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_field0 = sse_decode_String(deserializer);
    var var_field1 = sse_decode_field_value(deserializer);
    return (var_field0, var_field1);
  }

  @protected
  StreamMessageFfi sse_decode_stream_message_ffi(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_stream = sse_decode_String(deserializer);
    var var_sequence = sse_decode_u_32(deserializer);
    var var_timestamp = sse_decode_u_64(deserializer);
    var var_fields = sse_decode_Map_String_field_value(deserializer);
    return StreamMessageFfi(
        stream: var_stream,
        sequence: var_sequence,
        timestamp: var_timestamp,
        fields: var_fields);
  }

  @protected
  int sse_decode_u_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint32();
  }

  @protected
  BigInt sse_decode_u_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  BigInt sse_decode_usize(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          BytebeamSdk self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as BytebeamSdkImpl).frbInternalSseEncode(move: true), serializer);
  }

  @protected
  void
      sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          BytebeamSdk self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as BytebeamSdkImpl).frbInternalSseEncode(move: false),
        serializer);
  }

  @protected
  void
      sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          BytebeamSdk self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as BytebeamSdkImpl).frbInternalSseEncode(move: false),
        serializer);
  }

  @protected
  void sse_encode_Map_String_field_value(
      Map<String, FieldValue> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_record_string_field_value(
        self.entries.map((e) => (e.key, e.value)).toList(), serializer);
  }

  @protected
  void
      sse_encode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
          BytebeamSdk self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as BytebeamSdkImpl).frbInternalSseEncode(move: null), serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_available_update(
      AvailableUpdate self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.actionId, serializer);
    sse_encode_String(self.url, serializer);
    sse_encode_String(self.version, serializer);
    sse_encode_String(self.checksum, serializer);
    sse_encode_u_32(self.size, serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_box_autoadd_available_update(
      AvailableUpdate self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_available_update(self, serializer);
  }

  @protected
  void sse_encode_box_autoadd_stream_message_ffi(
      StreamMessageFfi self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_stream_message_ffi(self, serializer);
  }

  @protected
  void sse_encode_bytebeam_certificates(
      BytebeamCertificates self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.caCertificate, serializer);
    sse_encode_String(self.deviceCertificate, serializer);
    sse_encode_String(self.devicePrivateKey, serializer);
  }

  @protected
  void sse_encode_bytebeam_credentials(
      BytebeamCredentials self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.projectId, serializer);
    sse_encode_String(self.deviceId, serializer);
    sse_encode_String(self.apiUrl, serializer);
    sse_encode_bytebeam_certificates(self.authentication, serializer);
  }

  @protected
  void sse_encode_f_64(double self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putFloat64(self);
  }

  @protected
  void sse_encode_field_value(FieldValue self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    switch (self) {
      case FieldValue_Null():
        sse_encode_i_32(0, serializer);
      case FieldValue_String(field0: final field0):
        sse_encode_i_32(1, serializer);
        sse_encode_String(field0, serializer);
      case FieldValue_Int(field0: final field0):
        sse_encode_i_32(2, serializer);
        sse_encode_i_64(field0, serializer);
      case FieldValue_Bool(field0: final field0):
        sse_encode_i_32(3, serializer);
        sse_encode_bool(field0, serializer);
      case FieldValue_Float(field0: final field0):
        sse_encode_i_32(4, serializer);
        sse_encode_f_64(field0, serializer);
      case FieldValue_Array(field0: final field0):
        sse_encode_i_32(5, serializer);
        sse_encode_list_field_value(field0, serializer);
    }
  }

  @protected
  void sse_encode_i_64(PlatformInt64 self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putPlatformInt64(self);
  }

  @protected
  void sse_encode_list_field_value(
      List<FieldValue> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_field_value(item, serializer);
    }
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_list_record_string_field_value(
      List<(String, FieldValue)> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_record_string_field_value(item, serializer);
    }
  }

  @protected
  void sse_encode_list_stream_message_ffi(
      List<StreamMessageFfi> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_stream_message_ffi(item, serializer);
    }
  }

  @protected
  void sse_encode_opt_box_autoadd_available_update(
      AvailableUpdate? self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    sse_encode_bool(self != null, serializer);
    if (self != null) {
      sse_encode_box_autoadd_available_update(self, serializer);
    }
  }

  @protected
  void sse_encode_record_string_field_value(
      (String, FieldValue) self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.$1, serializer);
    sse_encode_field_value(self.$2, serializer);
  }

  @protected
  void sse_encode_stream_message_ffi(
      StreamMessageFfi self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.stream, serializer);
    sse_encode_u_32(self.sequence, serializer);
    sse_encode_u_64(self.timestamp, serializer);
    sse_encode_Map_String_field_value(self.fields, serializer);
  }

  @protected
  void sse_encode_u_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint32(self);
  }

  @protected
  void sse_encode_u_64(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_usize(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}

@sealed
class BytebeamSdkImpl extends RustOpaque implements BytebeamSdk {
  // Not to be used by end users
  BytebeamSdkImpl.frbInternalDcoDecode(List<dynamic> wire)
      : super.frbInternalDcoDecode(wire, _kStaticData);

  // Not to be used by end users
  BytebeamSdkImpl.frbInternalSseDecode(BigInt ptr, int externalSizeOnNative)
      : super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_BytebeamSdk,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_BytebeamSdk,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_BytebeamSdkPtr,
  );

  BytebeamCredentials get credentials =>
      RustLib.instance.api.crateApiBytebeamSdkAutoAccessorGetCredentials(
        that: this,
      );

  set credentials(BytebeamCredentials credentials) =>
      RustLib.instance.api.crateApiBytebeamSdkAutoAccessorSetCredentials(
          that: this, credentials: credentials);

  Future<Uint8List> downloadUpdate({required AvailableUpdate update}) =>
      RustLib.instance.api
          .crateApiBytebeamSdkDownloadUpdate(that: this, update: update);

  Future<AvailableUpdate?> fetchAvailableUpdate() =>
      RustLib.instance.api.crateApiBytebeamSdkFetchAvailableUpdate(
        that: this,
      );

  Future<void> uploadMessageFfi({required StreamMessageFfi message}) =>
      RustLib.instance.api
          .crateApiBytebeamSdkUploadMessageFfi(that: this, message: message);

  Future<void> uploadMessagesBatchFfi(
          {required List<StreamMessageFfi> messages}) =>
      RustLib.instance.api.crateApiBytebeamSdkUploadMessagesBatchFfi(
          that: this, messages: messages);
}
