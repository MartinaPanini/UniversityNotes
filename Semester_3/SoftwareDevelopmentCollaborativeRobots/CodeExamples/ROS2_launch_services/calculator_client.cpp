#include "rclcpp/rclcpp.hpp"
#include "calculator_msgs/srv/calc.hpp"

// #include <chrono>
// #include <cstdlib>
// #include <memory>

using namespace std::chrono_literals;
using namespace calculator_msgs::srv;
using namespace std::chrono;

const auto TIMEOUT = 1s;

int main(int argc, char **argv)
{
 rclcpp::init(argc, argv);

 if (argc != 4) {
     RCLCPP_INFO(rclcpp::get_logger("calculator_client"), "Usage: calculator_client X T Y");
     return 1;
 }

 std::shared_ptr<rclcpp::Node> node = rclcpp::Node::make_shared("calculator_client");
 rclcpp::Client<Calc>::SharedPtr client = node->create_client<Calc>("calculator");

 auto request = std::make_shared<Calc::Request>();
 request->a = atoll(argv[1]);
 request->b = atoll(argv[3]);

 switch (argv[2][0]){
 case '+':
   request->type = "sum"; break;
 case '-':
   request->type = "sub"; break;
 case '*':
   request->type = "mul"; break;
 case '/':
   request->type = "div"; break;
 default:
   RCLCPP_ERROR(rclcpp::get_logger("calculator_client"), "Invalid operation type");
   break;
 }

 while (!client->wait_for_service(TIMEOUT)) {
   if (!rclcpp::ok()) {
     RCLCPP_ERROR(rclcpp::get_logger("calculator_client"), "Interrupted while waiting for the service. Exiting.");
     return 0;
   }
   RCLCPP_INFO(rclcpp::get_logger("calculator_client"), "service not available, waiting again...");
 }

 auto result = client->async_send_request(request);

 if (rclcpp::spin_until_future_complete(node, result) ==
   rclcpp::FutureReturnCode::SUCCESS)
 {
   RCLCPP_INFO(rclcpp::get_logger("calculator_client"), "Result of %lf %s %lf = %lf",
     request->a, request->type.c_str(), request->b, result.get()->res);
 } else {
   RCLCPP_ERROR(rclcpp::get_logger("calculator_client"), "Failed to call service calculator");
 }
  rclcpp::shutdown();
 return 0;
}
