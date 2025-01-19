import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_cray/enums.dart';
import 'package:flutter_cray/flutter_cray_bindings_generated.dart';
import 'package:flutter_cray/loader.dart';
import 'package:flutter_cray/renderer.dart';
import 'package:flutter_cray/structs.dart';

/// A Dart wrapper for the native C-ray scene.
///
/// This class provides an interface to control the scene settings
/// and preferences using the native `c-ray` library.
class Scene {
  /// Private constructor to prevent direct instantiation.
  Scene._(this._ptr);

  /// Creates a new instance of a scene from the renderer.
  factory Scene.createFromRenderer(Renderer renderer) {
    final scenePtr = bindings.cr_renderer_scene_get(renderer.pointer);
    if (scenePtr == nullptr) {
      throw Exception('Failed to create scene from renderer.');
    }
    return Scene._(scenePtr);
  }

  /// The native pointer to the C-ray scene.
  final Pointer<cr_scene> _ptr;

  /// Returns the native pointer (for advanced use cases).
  Pointer<cr_scene> get pointer => _ptr;

  /// Adds a sphere to the scene.
  int addSphere(double radius) {
    final sphere = bindings.cr_scene_add_sphere(_ptr, radius);

    if (sphere == 0) {
      throw Exception('Failed to add sphere to the scene.');
    }

    return sphere;
  }

  /// Creates a new vertex buffer in the scene.
  int createVertexBuffer(CrVertexBufParam param) {
    final vertexBuffer =
        bindings.cr_scene_vertex_buf_new(_ptr, param.toPointer().ref);

    if (vertexBuffer == 0) {
      throw Exception('Failed to create vertex buffer.');
    }

    return vertexBuffer;
  }

  // /// Binds a vertex buffer to a mesh.
  // void bindVertexBufferToMesh(CrMesh mesh, Pointer<CrVertexBuf> buffer) {
  //   bindings.cr_mesh_bind_vertex_buf(_ptr, mesh, buffer.ref);
  // }

  // /// Binds faces to a mesh.
  // void bindFacesToMesh(CRMesh mesh, List<CRFace> faces) {
  //   final facePtr = malloc<CRFace>(faces.length);
  //   for (var i = 0; i < faces.length; i++) {
  //     facePtr[i] = faces[i];
  //   }

  //   try {
  //     bindings.crMeshBindFaces(_ptr, mesh, facePtr, faces.length);
  //   } finally {
  //     malloc.free(facePtr);
  //   }
  // }

  // /// Creates a new mesh in the scene.
  // CRMesh createMesh(String name) {
  //   final namePtr = name.toNativeUtf8();
  //   try {
  //     final mesh = bindings.crSceneMeshNew(_ptr, namePtr);
  //     if (mesh.address == 0) {
  //       throw Exception('Failed to create mesh.');
  //     }
  //     return mesh;
  //   } finally {
  //     malloc.free(namePtr);
  //   }
  // }

  // /// Gets a mesh from the scene by name.
  // CRMesh getMesh(String name) {
  //   final namePtr = name.toNativeUtf8();
  //   try {
  //     final mesh = bindings.crSceneGetMesh(_ptr, namePtr);
  //     if (mesh.address == 0) {
  //       throw Exception('Mesh with name "$name" not found.');
  //     }
  //     return mesh;
  //   } finally {
  //     malloc.free(namePtr);
  //   }
  // }

  // /// Gets the totals from the scene.
  // CRSceneTotals getTotals() {
  //   return bindings.crGetSceneTotals(_ptr);
  // }

  /// Releases any allocated resources for this scene.
  void dispose() {
    // No specific destructor is provided for scenes in your API.
    // Add cleanup logic here if necessary.
  }
}
