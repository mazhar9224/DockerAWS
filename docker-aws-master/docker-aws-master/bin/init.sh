#!/bin/bash -x
#	./bin/init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 101 ;
test -n "$apps" 		&& export apps	            || exit 102	;
test -n "$branch_app" 	        && export branch_app	    || exit 103	;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 104 ;
test -n "$debug" 		&& export debug	            || exit 105	;
test -n "$domain" 		&& export domain	    || exit 106	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 107 ;
test -n "$Identifier"		&& export Identifier        || exit 108 ;
test -n "$KeyName"              && export KeyName	    || exit 109	;
test -n "$mode"                 && export mode	            || exit 110	;
test -n "$repository_app"       && export repository_app    || exit 111	;
test -n "$RecordSetName1"	&& export RecordSetName1    || exit 112 ;
test -n "$RecordSetName2"	&& export RecordSetName2    || exit 113 ;
test -n "$RecordSetName3"	&& export RecordSetName3    || exit 114 ;
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit 115 ;
test -n "$stack"                && export stack	            || exit 116	;
test -n "$template"		&& export template    	    || exit 117 ;
test -n "$TypeMaster"		&& export TypeMaster 	    || exit 118 ;
test -n "$TypeWorker"		&& export TypeWorker 	    || exit 119 ;
test -n "$username_app"         && export username_app	    || exit 120	;
#########################################################################
path=bin								;
#########################################################################
file=aws-init.sh                                               		;
#########################################################################
./$path/$file                                                           ;
#########################################################################
file=cluster-init.sh							;
#########################################################################
./$path/$file                                                           ;
#########################################################################
file=app-init.sh                                               		;
#########################################################################
./$path/$file                                                           ;
#########################################################################
