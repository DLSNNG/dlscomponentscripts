#!/bin/bash
# $1: module name

source /home/ubuntu/workspace/scripts/module/populate-module-info.sh
source /home/ubuntu/workspace/scripts/module/populate-module-install.sh
source /home/ubuntu/workspace/scripts/module/populate-module-module.sh
source /home/ubuntu/workspace/scripts/module/populate-resource.sh

function build_module {
    # check if module name provided
    if [ -z "$1" ]; then 
        echo "ERROR: no module name provided."
        return 0
    fi
    # declare module name
    module_name=$1
    current_directory=$(pwd);
    working_directory=$current_directory/$module_name;
    includes=$working_directory/includes;
    # create directory structure
    mkdir -p $working_directory;
    mkdir -p $includes;
    mkdir -p $includes/components;
    mkdir -p $includes/controllers;
    mkdir -p $includes/views;
    mkdir -p $includes/resources;
    # create base core files
    touch $working_directory/$module_name.info;
    populate_info $working_directory $module_name;
    touch $working_directory/$module_name.install;
    populate_install $working_directory $module_name;
    touch $working_directory/$module_name.module;
    populate_module $working_directory $module_name;
    # create resource file
    resource_file=$includes/resources/$module_name.resources.inc;
    touch $resource_file;
    populate_resource $resource_file $module_name;
}

build_module $1;