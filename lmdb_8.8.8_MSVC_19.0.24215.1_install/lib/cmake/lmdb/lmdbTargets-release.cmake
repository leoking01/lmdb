#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "lmdb::lmdb" for configuration "Release"
set_property(TARGET lmdb::lmdb APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lmdb::lmdb PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/lmdb.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/lmdb.dll"
  )

list(APPEND _cmake_import_check_targets lmdb::lmdb )
list(APPEND _cmake_import_check_files_for_lmdb::lmdb "${_IMPORT_PREFIX}/lib/lmdb.lib" "${_IMPORT_PREFIX}/bin/lmdb.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
