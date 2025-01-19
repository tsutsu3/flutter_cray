import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_cray/enums.dart';
import 'package:flutter_cray/flutter_cray_bindings_generated.dart';

/// A bitmap representation of an image.
class CrBitmap {
  /// Creates a new instance of the C-ray bitmap.
  CrBitmap({
    required this.colorspace,
    required this.precision,
    required this.stride,
    required this.width,
    required this.height,
    required this.data,
  });

  /// Creates a new instance of the C-ray bitmap from a native pointer.
  factory CrBitmap.fromPointer(Pointer<cr_bitmap> ptr) {
    final bitmap = ptr.ref;

    final dataUnion = bitmap.data;

    dynamic data;
    if (bitmap.precision == 0) {
      // precision == 0, byte_ptr
      final bytePtr = dataUnion.byte_ptr;
      data = bytePtr.cast<Uint8>().asTypedList(bitmap.width * bitmap.height);
    } else {
      // precision == 1, float_ptr
      data = dataUnion.float_ptr.asTypedList(bitmap.width * bitmap.height);
    }

    return CrBitmap(
      colorspace: CrBitmapColorspace.fromInt(bitmap.colorspace),
      precision: CrBitmapPrecision.fromInt(bitmap.precision),
      stride: bitmap.stride,
      width: bitmap.width,
      height: bitmap.height,
      data: data,
    );
  }

  /// The colorspace of the bitmap.
  final CrBitmapColorspace colorspace;

  /// The precision of the bitmap.
  final CrBitmapPrecision precision;

  /// The stride of the bitmap.
  final int stride;

  /// The width of the bitmap.
  final int width;

  /// The height of the bitmap.
  final int height;

  /// Bitmap data.
  final dynamic data;

  @override
  String toString() {
    return 'CrBitmap(colorspace: $colorspace, precision: $precision, '
        'stride: $stride, width: $width, height: $height)';
  }
}

/// A 3D vector.
class CrVector {
  /// Creates a new instance of the C-ray vector.
  CrVector(this.x, this.y, this.z);

  /// Creates a new instance of the C-ray vector from a native pointer.
  factory CrVector.fromPointer(Pointer<cr_vector> ptr) {
    final ref = ptr.ref;
    return CrVector(ref.x, ref.y, ref.z);
  }

  /// The x-coordinate of the vector.
  final double x;

  /// The y-coordinate of the vector.
  final double y;

  /// The z-coordinate of the vector.
  final double z;

  /// Converts this vector to a native pointer.
  Pointer<cr_vector> toPointer() {
    final ptr = malloc<cr_vector>();
    ptr.ref
      ..x = x
      ..y = y
      ..z = z;
    return ptr;
  }

  @override
  String toString() => 'Vector(x: $x, y: $y, z: $z)';
}

/// A 2D coordinate.
class CrCoord {
  /// Creates a new instance of the C-ray coordinate.
  CrCoord(this.u, this.v);

  /// The u-coordinate of the coordinate.
  final double u;

  /// The v-coordinate of the coordinate.
  final double v;

  /// Converts this coordinate to a native pointer.
  Pointer<cr_coord> toPointer() {
    final ptr = malloc<cr_coord>();
    ptr.ref
      ..u = u
      ..v = v;
    return ptr;
  }
}

/// A parameter for a vertex buffer.
class CrVertexBufParam {
  /// Creates a new instance of the C-ray vertex buffer parameter.
  CrVertexBufParam({
    required this.vertices,
    required this.vertexCount,
    required this.normals,
    required this.normalCount,
    required this.texCoords,
    required this.texCoordCount,
  });

  /// The vertices of the vertex buffer.
  final List<CrVector> vertices;

  /// The number of vertices.
  final int vertexCount;

  /// The normals of the vertex buffer.
  final List<CrVector> normals;

  /// The number of normals.
  final int normalCount;

  /// The texture coordinates of the vertex buffer.
  final List<CrCoord> texCoords;

  /// The number of texture coordinates.
  final int texCoordCount;

  /// Allocates memory for the vertex buffer parameter.
  Pointer<cr_vertex_buf_param> toPointer() {
    final vertexPtr = malloc<cr_vector>(vertices.length);
    for (var i = 0; i < vertices.length; i++) {
      vertexPtr[i] = vertices[i].toPointer().ref;
    }

    final normalPtr = malloc<cr_vector>(normals.length);
    for (var i = 0; i < normals.length; i++) {
      normalPtr[i] = normals[i].toPointer().ref;
    }

    final texCoordPtr = malloc<cr_coord>(texCoords.length);
    for (var i = 0; i < texCoords.length; i++) {
      texCoordPtr[i] = texCoords[i].toPointer().ref;
    }

    final param = malloc<cr_vertex_buf_param>();

    param.ref
      ..vertices = vertexPtr
      ..vertex_count = vertexCount
      ..normals = normalPtr
      ..normal_count = normalCount
      ..tex_coords = texCoordPtr
      ..tex_coord_count = texCoordCount;

    malloc.free(param);

    return param;
  }
}
