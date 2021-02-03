#!/bin/bash -x
#	./bin/app-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 401 ;
test -n "$apps" 		&& export apps	            || exit 402	;
test -n "$branch_app" 	        && export branch_app	    || exit 403	;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 404	;
test -n "$debug" 		&& export debug	            || exit 405	;
test -n "$domain" 		&& export domain	    || exit 406	;
test -n "$mode"                 && export mode	            || exit 407	;
test -n "$repository_app"       && export repository_app    || exit 408	;
test -n "$stack"                && export stack	            || exit 409	;
test -n "$username_app"         && export username_app	    || exit 410	;
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
path=bin								;
#########################################################################
file=app-init-config-deploy.sh      	                                ;
#########################################################################
./$path/$file                                                           ;
#########################################################################
file=app-init-deploy.sh      	                                	;
#########################################################################
./$path/$file                                                           ;
#########################################################################
file=app-init-config-remove.sh      	                                ;
#########################################################################
./$path/$file                                                           ;
#########################################################################
