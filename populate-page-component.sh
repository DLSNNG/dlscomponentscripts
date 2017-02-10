#!/bin/bash

function populate_component {
# $1: class name
# $2: file path

#check if class name provided
if [ -z "$1" ]; then 
    echo "ERROR: no class name provided."
    return 0
fi

#check if file path provided
if [ -z "$2" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

class_name=$1;
file_path=$2;

cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_components', 'core');
  
  class $class_name extends dcomponent {
  
    function propTypes() {
      return array(
        'title' => propType::String(),
      );
    }
    
    function render() {
      \$props = \$this->props;
      
      \$block = array(
        '#type' => 'markup',
        '#markup' => \$props['title'],
      );
      
      return \$block;
    }
  }

EOF

}