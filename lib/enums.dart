import 'package:flutter_cray/flutter_cray_bindings_generated.dart';

/// Enum for the renderer parameters.
enum CrRendererParamEnum {
  // ---------- Number ----------

  /// Number of threads to use for rendering.
  threads,

  /// Number of samples per pixel.
  samples,

  /// Number of bounces for ray tracing.
  bounces,

  /// Width of the tile.
  tileWidth,

  /// Height of the tile.
  tileHeight,

  /// Order in which the tiles are rendered.
  tileOrder,

  /// Number of output images.
  outputNum,

  /// Width of the output image.
  overrideWidth,

  /// Height of the output image.
  overrideHeight,

  /// Camera to use for rendering.
  overrideCam,

  /// Whether the rendering is iterative.
  isIterative,

  // ---------- String ----------

  /// Path to save the output image.
  outputPath,

  /// Path to the asset directory.
  assetPath,

  /// Name of the output image.
  outputName,

  /// Filetype of the output image.
  outputFiletype,

  /// List of nodes to use for rendering.
  nodeList,

  /// Blender mode.
  blenderMode;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrRendererParamEnum.threads:
        return cr_renderer_param.cr_renderer_threads;
      case CrRendererParamEnum.samples:
        return cr_renderer_param.cr_renderer_samples;
      case CrRendererParamEnum.bounces:
        return cr_renderer_param.cr_renderer_bounces;
      case CrRendererParamEnum.tileWidth:
        return cr_renderer_param.cr_renderer_tile_width;
      case CrRendererParamEnum.tileHeight:
        return cr_renderer_param.cr_renderer_tile_height;
      case CrRendererParamEnum.tileOrder:
        return cr_renderer_param.cr_renderer_tile_order;
      case CrRendererParamEnum.outputNum:
        return cr_renderer_param.cr_renderer_output_num;
      case CrRendererParamEnum.overrideWidth:
        return cr_renderer_param.cr_renderer_override_width;
      case CrRendererParamEnum.overrideHeight:
        return cr_renderer_param.cr_renderer_override_height;
      case CrRendererParamEnum.overrideCam:
        return cr_renderer_param.cr_renderer_override_cam;
      case CrRendererParamEnum.isIterative:
        return cr_renderer_param.cr_renderer_is_iterative;
      case CrRendererParamEnum.outputPath:
        return cr_renderer_param.cr_renderer_output_path;
      case CrRendererParamEnum.assetPath:
        return cr_renderer_param.cr_renderer_asset_path;
      case CrRendererParamEnum.outputName:
        return cr_renderer_param.cr_renderer_output_name;
      case CrRendererParamEnum.outputFiletype:
        return cr_renderer_param.cr_renderer_output_filetype;
      case CrRendererParamEnum.nodeList:
        return cr_renderer_param.cr_renderer_node_list;
      case CrRendererParamEnum.blenderMode:
        return cr_renderer_param.cr_renderer_blender_mode;
    }
  }

  /// Converts integer value back to enum
  static CrRendererParamEnum fromInt(int value) {
    switch (value) {
      case cr_renderer_param.cr_renderer_threads:
        return CrRendererParamEnum.threads;
      case cr_renderer_param.cr_renderer_samples:
        return CrRendererParamEnum.samples;
      case cr_renderer_param.cr_renderer_bounces:
        return CrRendererParamEnum.bounces;
      case cr_renderer_param.cr_renderer_tile_width:
        return CrRendererParamEnum.tileWidth;
      case cr_renderer_param.cr_renderer_tile_height:
        return CrRendererParamEnum.tileHeight;
      case cr_renderer_param.cr_renderer_tile_order:
        return CrRendererParamEnum.tileOrder;
      case cr_renderer_param.cr_renderer_output_num:
        return CrRendererParamEnum.outputNum;
      case cr_renderer_param.cr_renderer_override_width:
        return CrRendererParamEnum.overrideWidth;
      case cr_renderer_param.cr_renderer_override_height:
        return CrRendererParamEnum.overrideHeight;
      case cr_renderer_param.cr_renderer_override_cam:
        return CrRendererParamEnum.overrideCam;
      case cr_renderer_param.cr_renderer_is_iterative:
        return CrRendererParamEnum.isIterative;
      case cr_renderer_param.cr_renderer_output_path:
        return CrRendererParamEnum.outputPath;
      case cr_renderer_param.cr_renderer_asset_path:
        return CrRendererParamEnum.assetPath;
      case cr_renderer_param.cr_renderer_output_name:
        return CrRendererParamEnum.outputName;
      case cr_renderer_param.cr_renderer_output_filetype:
        return CrRendererParamEnum.outputFiletype;
      case cr_renderer_param.cr_renderer_node_list:
        return CrRendererParamEnum.nodeList;
      case cr_renderer_param.cr_renderer_blender_mode:
        return CrRendererParamEnum.blenderMode;
      default:
        throw ArgumentError('Invalid CrRendererParamEnum value: $value');
    }
  }
}

/// Enum for the tile state.
enum CrTileStateEnum {
  /// The tile is ready to be rendered.
  ready,

  /// The tile is currently being rendered.
  rendering,

  /// The tile has been rendered.
  finished;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrTileStateEnum.ready:
        return cr_tile_state.cr_tile_ready_to_render;
      case CrTileStateEnum.rendering:
        return cr_tile_state.cr_tile_rendering;
      case CrTileStateEnum.finished:
        return cr_tile_state.cr_tile_finished;
    }
  }

  /// Converts integer value back to enum
  static CrTileStateEnum fromInt(int value) {
    switch (value) {
      case cr_tile_state.cr_tile_ready_to_render:
        return CrTileStateEnum.ready;
      case cr_tile_state.cr_tile_rendering:
        return CrTileStateEnum.rendering;
      case cr_tile_state.cr_tile_finished:
        return CrTileStateEnum.finished;
      default:
        throw ArgumentError('Invalid CrTileState value: $value');
    }
  }
}

/// Enum for the callback events.
enum CrRendererCallbackEnum {
  /// Callback for when the renderer starts.
  onStart,

  /// Callback for when the renderer stops.
  onStop,

  /// Callback for status updates.
  statusUpdate,

  /// Callback for when the renderer state changes.
  onStateChanged,

  /// Callback for when an interactive pass is finished.
  onInteractivePassFinished;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrRendererCallbackEnum.onStart:
        return cr_renderer_callback.cr_cb_on_start;
      case CrRendererCallbackEnum.onStop:
        return cr_renderer_callback.cr_cb_on_stop;
      case CrRendererCallbackEnum.statusUpdate:
        return cr_renderer_callback.cr_cb_status_update;
      case CrRendererCallbackEnum.onStateChanged:
        return cr_renderer_callback.cr_cb_on_state_changed;
      case CrRendererCallbackEnum.onInteractivePassFinished:
        return cr_renderer_callback.cr_cb_on_interactive_pass_finished;
    }
  }

  /// Converts integer value back to enum
  static CrRendererCallbackEnum fromInt(int value) {
    switch (value) {
      case cr_renderer_callback.cr_cb_on_start:
        return CrRendererCallbackEnum.onStart;
      case cr_renderer_callback.cr_cb_on_stop:
        return CrRendererCallbackEnum.onStop;
      case cr_renderer_callback.cr_cb_status_update:
        return CrRendererCallbackEnum.statusUpdate;
      case cr_renderer_callback.cr_cb_on_state_changed:
        return CrRendererCallbackEnum.onStateChanged;
      case cr_renderer_callback.cr_cb_on_interactive_pass_finished:
        return CrRendererCallbackEnum.onInteractivePassFinished;
      default:
        throw ArgumentError('Invalid CrRendererCallbackEnum value: $value');
    }
  }
}

/// Enum for the camera parameters.
enum CrCameraParamEnum {
  /// Field of view of the camera.
  fov,

  /// Focus distance of the camera.
  focusDistance,

  /// F-stops of the camera.
  fStops,

  /// X position of the camera.
  poseX,

  /// Y position of the camera.
  poseY,

  /// Z position of the camera.
  poseZ,

  /// Roll angle of the camera.
  poseRoll,

  /// Pitch angle of the camera.
  posePitch,

  /// Yaw angle of the camera.
  poseYaw,

  /// Time of the camera.
  time,

  /// Resolution width of the camera.
  resX,

  /// Resolution height of the camera.
  resY,

  /// Blender coordinate of the camera.
  blenderCoord;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrCameraParamEnum.fov:
        return cr_camera_param.cr_camera_fov;
      case CrCameraParamEnum.focusDistance:
        return cr_camera_param.cr_camera_focus_distance;
      case CrCameraParamEnum.fStops:
        return cr_camera_param.cr_camera_fstops;
      case CrCameraParamEnum.poseX:
        return cr_camera_param.cr_camera_pose_x;
      case CrCameraParamEnum.poseY:
        return cr_camera_param.cr_camera_pose_y;
      case CrCameraParamEnum.poseZ:
        return cr_camera_param.cr_camera_pose_z;
      case CrCameraParamEnum.poseRoll:
        return cr_camera_param.cr_camera_pose_roll;
      case CrCameraParamEnum.posePitch:
        return cr_camera_param.cr_camera_pose_pitch;
      case CrCameraParamEnum.poseYaw:
        return cr_camera_param.cr_camera_pose_yaw;
      case CrCameraParamEnum.time:
        return cr_camera_param.cr_camera_time;
      case CrCameraParamEnum.resX:
        return cr_camera_param.cr_camera_res_x;
      case CrCameraParamEnum.resY:
        return cr_camera_param.cr_camera_res_y;
      case CrCameraParamEnum.blenderCoord:
        return cr_camera_param.cr_camera_blender_coord;
    }
  }

  /// Converts integer value back to enum
  static CrCameraParamEnum fromInt(int value) {
    switch (value) {
      case cr_camera_param.cr_camera_fov:
        return CrCameraParamEnum.fov;
      case cr_camera_param.cr_camera_focus_distance:
        return CrCameraParamEnum.focusDistance;
      case cr_camera_param.cr_camera_fstops:
        return CrCameraParamEnum.fStops;
      case cr_camera_param.cr_camera_pose_x:
        return CrCameraParamEnum.poseX;
      case cr_camera_param.cr_camera_pose_y:
        return CrCameraParamEnum.poseY;
      case cr_camera_param.cr_camera_pose_z:
        return CrCameraParamEnum.poseZ;
      case cr_camera_param.cr_camera_pose_roll:
        return CrCameraParamEnum.poseRoll;
      case cr_camera_param.cr_camera_pose_pitch:
        return CrCameraParamEnum.posePitch;
      case cr_camera_param.cr_camera_pose_yaw:
        return CrCameraParamEnum.poseYaw;
      case cr_camera_param.cr_camera_time:
        return CrCameraParamEnum.time;
      case cr_camera_param.cr_camera_res_x:
        return CrCameraParamEnum.resX;
      case cr_camera_param.cr_camera_res_y:
        return CrCameraParamEnum.resY;
      case cr_camera_param.cr_camera_blender_coord:
        return CrCameraParamEnum.blenderCoord;
      default:
        throw ArgumentError('Invalid CrCameraParamEnum value: $value');
    }
  }
}

/// Enum for the object types.
enum CrObjectType {
  /// Mesh object type.
  mesh,

  /// Sphere object type.
  sphere;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrObjectType.mesh:
        return cr_object_type.cr_object_mesh;
      case CrObjectType.sphere:
        return cr_object_type.cr_object_sphere;
    }
  }

  /// Converts integer value back to enum
  static CrObjectType fromInt(int value) {
    switch (value) {
      case cr_object_type.cr_object_mesh:
        return CrObjectType.mesh;
      case cr_object_type.cr_object_sphere:
        return CrObjectType.sphere;
      default:
        throw ArgumentError('Invalid CrObjectType value: $value');
    }
  }
}

/// Enum for the log levels.
enum CrLogLevel {
  /// Silent log level.
  silent,

  /// Info log level.
  info,

  /// Debug log level.
  debug,

  /// Spam log level.
  spam;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrLogLevel.silent:
        return cr_log_level.Silent;
      case CrLogLevel.info:
        return cr_log_level.Info;
      case CrLogLevel.debug:
        return cr_log_level.Debug;
      case CrLogLevel.spam:
        return cr_log_level.Spam;
    }
  }

  /// Converts integer value back to enum
  static CrLogLevel fromInt(int value) {
    switch (value) {
      case cr_log_level.Silent:
        return CrLogLevel.silent;
      case cr_log_level.Info:
        return CrLogLevel.info;
      case cr_log_level.Debug:
        return CrLogLevel.debug;
      case cr_log_level.Spam:
        return CrLogLevel.spam;
      default:
        throw ArgumentError('Invalid CrLogLevel value: $value');
    }
  }
}

/// Enum for the bitmap colorspace.
enum CrBitmapColorspace {
  /// Linear colorspace.
  linear,

  /// sRGB colorspace.
  sRGB;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrBitmapColorspace.linear:
        return cr_bm_colorspace.cr_bm_linear;
      case CrBitmapColorspace.sRGB:
        return cr_bm_colorspace.cr_bm_sRGB;
    }
  }

  /// Converts integer value back to enum
  static CrBitmapColorspace fromInt(int value) {
    switch (value) {
      case cr_bm_colorspace.cr_bm_linear:
        return CrBitmapColorspace.linear;
      case cr_bm_colorspace.cr_bm_sRGB:
        return CrBitmapColorspace.sRGB;
      default:
        throw ArgumentError('Invalid CrBitmapColorspace value: $value');
    }
  }
}

/// Enum for the bitmap channel precision.
enum CrBitmapPrecision {
  /// 8-bit channel precision.
  char,

  /// 32-bit floating point channel precision.
  float;

  /// Converts enum to integer value
  int toInt() {
    switch (this) {
      case CrBitmapPrecision.char:
        return cr_bm_channel_precision.cr_bm_char;
      case CrBitmapPrecision.float:
        return cr_bm_channel_precision.cr_bm_float;
    }
  }

  /// Converts integer value back to enum
  static CrBitmapPrecision fromInt(int value) {
    switch (value) {
      case cr_bm_channel_precision.cr_bm_char:
        return CrBitmapPrecision.char;
      case cr_bm_channel_precision.cr_bm_float:
        return CrBitmapPrecision.float;
      default:
        throw ArgumentError('Invalid CrBitmapPrecision value: $value');
    }
  }
}
