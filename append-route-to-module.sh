#!/bin/bash
# $1: module name
# $2: page name
# $3: class name
# $4: route

function update_module_routes {
  current_directory=$(pwd);
  route_text=$(get_route_text $1 $2 $3 $4);
  sed -i "/return \$routes;/i $route_text" $current_directory/$1.module;
}

function get_route_text {
  
  #check if module name provided
  if [ -z "$1" ]; then 
      echo "ERROR: no module name provided."
      return 0
  fi
  
  #check if page name provided
  if [ -z "$2" ]; then 
      echo "ERROR: no class name provided."
      return 0
  fi
  
  #check if class name provided
  if [ -z "$3" ]; then 
      echo "ERROR: no class name provided."
      return 0
  fi
  
  #check if file path provided
  if [ -z "$4" ]; then 
      echo "ERROR: no route provided."
      return 0
  fi
  
  module_name=$1;
  page_name=$2;
  class_name=$3;
  route=$4;
  
  echo "\\\
  \$routes['${page_name}'] = array( \n\
    'title' => '${class_name}', \\n\
    'page callback' => 'view_${module_name}_${page_name}', \n\
    'access arguments' => array('view $module_name'), \n\
    'file path' => \$path, \n\
    'file' => '${module_name}.${page_name}.inc', \n\
  ); \n\
  ";
}