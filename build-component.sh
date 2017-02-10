#!/bin/bash
# $1: component name

source /home/ubuntu/workspace/scripts/module/underscore_to_camel_case.sh;
source /home/ubuntu/workspace/scripts/module/populate-page-component.sh

function build_component {
    # check if component name provided
    if [ -z "$1" ]; then 
        echo "ERROR: no component name provided."
        return 0
    fi
    # init variables
    component_name=$1
    class_name=$(underscore_to_camel_case $component_name);
    current_directory=$(pwd);
    module_name=${current_directory##*/}
    # compose directory paths
    includes=$current_directory/includes;
    components_directory=$includes/components;
    # create component file
    component_path=$components_directory/${module_name}.${component_name}_component.inc;
    touch $component_path;
    # populate component file
    populate_component $class_name $component_path;
}

build_component $1;