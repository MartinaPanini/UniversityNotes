#include "my_examples/my_publisher.hpp"

using namespace std::chrono_literals;

MyPublisher::MyPublisher(): Node("my_publisher"), count_(0)
{
    publisher_ = this->create_publisher<std_msgs::msg::String>("my_topic", 10);
    timer_ = this->create_wall_timer(500ms, std::bind(&MyPublisher::timer_callback, this));
}

void MyPublisher::timer_callback()
{
    auto message = std_msgs::msg::String();
    message.data = "Hello, world! " + std::to_string(count_++);
    RCLCPP_INFO(this->get_logger(), "Publishing: '%s'", message.data.c_str());
    publisher_->publish(message);
}