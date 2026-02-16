#include "rclcpp/rclcpp.hpp"
// #include <memory>

#include "calculator_msgs/srv/calc.hpp"

class Calculator : public rclcpp::Node {
public:
 Calculator() : Node("calculator") 
 {
   this->service_ = this->create_service< calculator_msgs::srv::Calc >(
     "calculator", std::bind(&Calculator::calc, this, std::placeholders::_1, std::placeholders::_2));
 }
private:
 void calc(const std::shared_ptr< calculator_msgs::srv::Calc::Request > request,
           std::shared_ptr< calculator_msgs::srv::Calc::Response > response){
            if (request->type == "sum"){
              response->res = request->a + request->b;
            }
            else if (request->type == "sub"){
              response->res = request->a - request->b;
            }
            else if (request->type == "mul"){
              response->res = request->a * request->b;
            }
            else if (request->type == "div"){
              response->res = request->a / request->b;
            }
            else {
              RCLCPP_ERROR(this->get_logger(), "Invalid operation type");
              return;
            }
            RCLCPP_INFO(this->get_logger(), "Operation: %s %s %s = %s",
              std::to_string(request->a).c_str(), request->type.c_str(),
              std::to_string(request->b).c_str(), std::to_string(response->res).c_str());
           }

 rclcpp::Service< calculator_msgs::srv::Calc >::SharedPtr service_;
};

int main(int argc, char **argv)
{
 rclcpp::init(argc, argv);
 auto node = std::make_shared<Calculator>();
 rclcpp::spin(node);
 rclcpp::shutdown();
}