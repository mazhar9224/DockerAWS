#!/bin/bash -x
#	./bin/app-init-config-remove.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$apps"                 && export apps           || exit 901    ;
test -n "$A"	                && export A              || exit 902    ;
test -n "$branch_docker_aws"    && export branch_docker_aws||exit 903   ;
test -n "$branch_app"           && export branch_app     || exit 904    ;
test -n "$debug"                && export debug          || exit 905    ;
test -n "$domain"               && export domain         || exit 906    ;
test -n "$mode"                 && export mode           || exit 907    ;
test -n "$repository_app"       && export repository_app || exit 908    ;
test -n "$stack"                && export stack          || exit 909    ;
test -n "$username_app"         && export username_app   || exit 910    ;
#########################################################################
file=common-functions.sh						;
path=lib                                 				;
#########################################################################
source ./$path/$file                                                    ;
#########################################################################
export -f encode_string							;
export -f exec_remote_file						;
export -f send_command							;
export -f send_list_command						;
export -f send_remote_file						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
file=app-deploy.sh      	                                        ;
path=bin                                 				;
#########################################################################
export deploy_file=app-config-remove.sh                                 ;
export deploy_path=$path						;
#########################################################################
./$path/$file                                                           ;
#########################################################################
