function(eth_apply TARGET REQUIRED SUBMODULE)

	set(UTILS_DIR "${ETH_CMAKE_DIR}/../utils" CACHE PATH "The path to utils libraries directory")
    set(UTILS_BUILD_DIR_NAME "build" CACHE STRING "Utils build directory name")
    set(UTILS_BUILD_DIR "${UTILS_DIR}/${UTILS_BUILD_DIR_NAME}")
    set(CMAKE_LIBRARY_PATH ${UTILS_BUILD_DIR} ${CMAKE_LIBRARY_PATH})

	find_package(Utils)

	target_include_directories(${TARGET} SYSTEM BEFORE PUBLIC ${Utils_INCLUDE_DIRS})

	if (${SUBMODULE} STREQUAL "secp256k1")
		if (NOT EMSCRIPTEN)
			eth_use(${EXECUTABLE} ${REQUIRED} Gmp)
		endif()
		target_link_libraries(${TARGET} ${Utils_SECP256K1_LIBRARIES})
		target_compile_definitions(${TARGET} PUBLIC ETH_HAVE_SECP256K1)
	endif()

	if (${SUBMODULE} STREQUAL "scrypt")
		target_link_libraries(${TARGET} ${Utils_SCRYPT_LIBRARIES})
	endif()

endfunction()
