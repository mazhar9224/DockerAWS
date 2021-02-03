#!/bin/bash -x
#	./bin/app-deploy.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$A"                    && export A                 || exit 1001 ;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 1002 ;
test -n "$domain"               && export domain            || exit 1003 ;
#########################################################################
test -n "$apps"			|| exit 1004				;
test -n "$branch_app"		|| exit 1005				;
test -n "$debug"		|| exit 1006				;
test -n "$deploy_file"		|| exit 1007				;
test -n "$deploy_path"		|| exit 1008				;
test -n "$mode"			|| exit 1009				;
test -n "$repository_app"	|| exit 1010				;
test -n "$stack"		|| exit 1011				;
test -n "$username_app"		|| exit 1012				;
#########################################################################
apps=$(									\
  encode_string "$apps"							\
)									;
export=" 								\
  export debug=$debug 							\
"									;
file=$deploy_file							;
path=$deploy_path							;
targets=" 								\
  InstanceMaster1 							\
"			 						;
#########################################################################
sleep=10								;
#########################################################################
export=" 								\
  $export 								\
  &&									\
  export A=$A								\
  &&									\
  export apps=$apps							\
  &&									\
  export branch_app=$branch_app						\
  &&									\
  export branch_docker_aws=$branch_docker_aws				\
  &&									\
  export domain=$domain							\
  &&									\
  export mode=$mode							\
  &&									\
  export repository_app=$repository_app					\
  &&									\
  export username_app=$username_app					\
"									;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets" ;
#########################################################################
