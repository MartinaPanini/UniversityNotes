cmake_minimum_required(VERSION 3.8)
project(my_examples)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)


## build
add_executable(publisher_node src/publisher_standalone.cpp)
ament_target_dependencies(publisher_node rclcpp std_msgs)
target_compile_features(publisher_node PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17

add_library(my_publisher_lib src/my_publisher.cpp)
ament_target_dependencies(my_publisher_lib rclcpp std_msgs)
target_include_directories(my_publisher_lib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#  $<INSTALL_INTERFACE:include>)
  $<INSTALL_INTERFACE:include/${PROJECT_NAME}>)
target_compile_features(my_publisher_lib PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17

add_executable(my_publisher_node src/my_publisher_main.cpp)
ament_target_dependencies(my_publisher_node rclcpp)
target_link_libraries(my_publisher_node my_publisher_lib)
target_compile_features(my_publisher_node PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17

add_executable(subscriber_node src/subscriber_standalone.cpp)
ament_target_dependencies(subscriber_node rclcpp std_msgs)
target_compile_features(subscriber_node PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17


## install

# install executables
install(TARGETS 
  publisher_node
  my_publisher_node
  subscriber_node
  DESTINATION lib/${PROJECT_NAME})

# install libraries
ament_export_targets(export_${PROJECT_NAME} HAS_LIBRARY_TARGET)
ament_export_dependencies(rclcpp std_msgs)
install(
  DIRECTORY include/
  DESTINATION include/${PROJECT_NAME}
)
install(
  TARGETS my_publisher_lib
  EXPORT export_${PROJECT_NAME}
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
)

## test  
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()