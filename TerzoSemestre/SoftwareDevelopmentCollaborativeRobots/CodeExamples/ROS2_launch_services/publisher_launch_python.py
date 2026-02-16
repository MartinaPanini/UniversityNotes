import os

from ament_index_python import get_package_share_directory

from launch import LaunchDescription
from launch_ros.actions import Node

# needed for arguments
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch.substitutions import TextSubstitution

## needed to include a launch
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.launch_description_sources import AnyLaunchDescriptionSource

def generate_launch_description():

     # args that can be set from the command line or a default will be used
    topic_name_arg = DeclareLaunchArgument(
        "topic_name_arg", default_value=TextSubstitution(text="topic_launch")
    )
    
    # include another launch file
    launch_include_yaml = IncludeLaunchDescription(
        AnyLaunchDescriptionSource(
            os.path.join(
                get_package_share_directory('custom_pkg'),
                'launch/publisher_launch_yaml.yaml'))
    )

    parameters_file = os.path.join(get_package_share_directory('custom_pkg'), 'config','my_publisher.yaml')

    pub_node = Node(
        package='custom_pkg',
        executable='custom_pub_standalone',
        #namespace='custom_publisher',                ## adds the namespace custom_publisher to the name of the node, topics etc.. :
                                                        ## from /my_publisher to /custom_publisher/my_publisher, 
                                                        ## from /default_topic to /custom_publisher/default_topic and so on
        name='my_publisher_launch',                  ## maps the name of the node from /my_publisher to /my_publisher_launch
        output="screen",
        emulate_tty=True,                            ## with these two lines we ensure our output is printed in our console
        # parameters=[{'topic_name' : 'topic_launch'}]                        ## sets the param topic_name to the value topic_launch
        # parameters=[{'topic_name' : LaunchConfiguration('topic_name_arg')}] ## sets the param topic_name to the value topic_launch, but the argument can be passd from comman line
        parameters=[parameters_file]
    )
    
    sub_node = Node(
        package='custom_pkg',
        executable='custom_sub_standalone',
        name='my_subscriber_launch',                  
        output="screen",
        emulate_tty=True,
        remappings=[
            ('/my_topic', '/default_topic'),
        ]         
    )

    return LaunchDescription([
        topic_name_arg,
        launch_include_yaml,
        pub_node,
        sub_node
    ])