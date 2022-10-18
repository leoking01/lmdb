cmake_minimum_required(VERSION 3.1.0)
project(lmdb C)

# Provides ${CMAKE_INSTALL_LIBDIR/BINDIR}
include(GNUInstallDirs)

set(MDB_DEVEL "" CACHE STRING "Enable functions under development")
set(MDB_DEBUG "0" CACHE STRING "Enable debug output.  Needs variable argument macros (a C99 feature).
Set this to 1 for copious tracing. Set to 2 to add dumps of all IDLs
read from and written to the database (used for free space management).")

set(MDB_USE_POSIX_SEM "" CACHE STRING "Use posix semiphores (instead of mutexes) from <semiphore.h>")
set(MDB_DSYNC "" CACHE STRING "Use O_DSYNC on write to avoid extra syscall to flush.")
set(MDB_FDATASYNC "fsync" CACHE STRING "Function to use for syncing, define to `fsync` if `fdatasync` doesn exist")
set(MDB_FDATASYNC_WORKS "1" CACHE STRING "Use if fdatasync is guarenteed to work. May not be the case for old kernels and ext3/4.")
set(MDB_USE_PWRITEV "" CACHE STRING "If the `pwritev` function is available.")
set(MDB_USE_ROBUST "" CACHE STRING "Some platforms define the EOWNERDEAD error code
 even though they don't support Robust Mutexes.
 Unset or use MDB_USE_POSIX_SEM on such platforms.")



set(PROJECT_VERSION "8.8.8")
set(PACKAGE_VERSION  "8.8.8")

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "d")
endif()
#link_directories(${CMAKE_BINARY_DIR} )

message( "CMAKE_C_COMPILER = ${CMAKE_C_COMPILER}"  )
message( "CMAKE_C_COMPILER_VERSION = ${CMAKE_C_COMPILER_VERSION}"  )
message( "CMAKE_CXX_PLATFORM_ID = ${CMAKE_CXX_PLATFORM_ID}"  )
message( "CMAKE_CXX_COMPILER_TARGET = ${CMAKE_CXX_COMPILER_TARGET}"  )
message( "CMAKE_CXX_COMPILER_AR = ${CMAKE_CXX_COMPILER_AR}"  )
message( "CMAKE_C_COMPILER_ABI = ${CMAKE_C_COMPILER_ABI}"  )
message( "CMAKE_C_COMPILER_TARGET = ${CMAKE_C_COMPILER_TARGET}"  )
message( "CMAKE_HOST_SYSTEM = ${CMAKE_HOST_SYSTEM}"  )
message( "CMAKE_HOST_SYSTEM_NAME = ${CMAKE_HOST_SYSTEM_NAME}"  )
message( "CMAKE_VS_PLATFORM_NAME = ${CMAKE_VS_PLATFORM_NAME}"  )
message( "CMAKE_VS_PLATFORM_TOOLSET = ${CMAKE_VS_PLATFORM_TOOLSET}"  )
message( "CMAKE_CXX_COMPILER_VERSION = ${CMAKE_CXX_COMPILER_VERSION}"  )
#message(  "CMAKE_CXX_COMPILER_TARGET= ${CMAKE_CXX_COMPILER_TARGET}"   )
message(  "CMAKE_CXX_COMPILER_ABI= ${CMAKE_CXX_COMPILER_ABI}"   )
message(  "CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN= ${CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN}"   )
message(  "CMAKE_CXX_COMPILER_ID= ${CMAKE_CXX_COMPILER_ID}"   )
message(  "CMAKE_CXX_COMPILER_ARCHITECTURE_ID= ${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}"   )
#message(  "CMAKE_HOST_SYSTEM_NAME= ${CMAKE_HOST_SYSTEM_NAME}"   )



# 改变安装路径可以使用下面的语句，Unix: "/usr/local", Windows: "c:/Program Files/${PROJECT_NAME}" 为默认值，所有的DESTINATION均以此目录为根目录
# set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/mymath)
#set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/../${PROJECT_NAME}_${PROJECT_VERSION}_${CMAKE_HOST_SYSTEM}_${CMAKE_CXX_COMPILER_ID}_${CMAKE_CXX_COMPILER_VERSION}_install)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/../${PROJECT_NAME}_${PROJECT_VERSION}_${CMAKE_C_COMPILER_ID}_${CMAKE_C_COMPILER_VERSION}_install)







#add_library(lmdb STATIC mdb.c midl.c)
add_library(lmdb SHARED  mdb.c midl.c)
set_property(TARGET lmdb PROPERTY PUBLIC_HEADER lmdb.h)
set_property(TARGET lmdb PROPERTY PRIVATE_HEADER midl.h)
set_property(TARGET lmdb PROPERTY C_STANDARD 99)

install(TARGETS lmdb
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
target_include_directories(lmdb PUBLIC 
	$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
	$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

export(TARGETS lmdb FILE LmdbConfig.cmake)


#//-------------------------------

# install
include(CMakePackageConfigHelpers)

target_include_directories(lmdb PRIVATE  ${CMAKE_SOURCE_DIR}/include )
set_target_properties(lmdb PROPERTIES PUBLIC_HEADER ${CMAKE_SOURCE_DIR}/lmdb.h)





#//---MyMath---------------------------------------------
# 写入库的版本信息

write_basic_package_version_file(
    lmdbConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

# 将库文件，可执行文件，头文件安装到指定目录
install(TARGETS lmdb
    EXPORT lmdbTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    PUBLIC_HEADER DESTINATION include
)

# 将库的相关信息输出为lmdbConfig.cmake，供find_package查找
install(EXPORT lmdbTargets
    FILE lmdbTargets.cmake
    NAMESPACE lmdb::
    DESTINATION lib/cmake/lmdb
)

configure_file( lmdbConfig.cmake.in  lmdb/lmdbConfig.cmake @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/lmdb/lmdbConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/lmdbConfigVersion.cmake"
    DESTINATION lib/cmake/lmdb
)


message( "{lmdb_INCLUDE_DIRS} = ${lmdb_INCLUDE_DIRS}"  )
message( "{INTERFACE_INCLUDE_DIRECTORIES} = ${INTERFACE_INCLUDE_DIRECTORIES}"  )



