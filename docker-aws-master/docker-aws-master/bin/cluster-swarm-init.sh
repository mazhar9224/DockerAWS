#!/bin/bash -x
#	./bin/cluster-swarm-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"	|| exit 501					;
test -n "$stack"	|| exit 502					;
#########################################################################
service=docker								;
sleep=10								;
#########################################################################
targets=" InstanceMaster1 " 						;
#########################################################################
service_wait_targets $service $sleep $stack "$targets"			;
#########################################################################
command=" 								\
  docker swarm init 2> /dev/null | grep token --max-count 1 		\
" 									;
token_worker="								\
  $(									\
    send_wait_targets "$command" $sleep $stack "$targets"		\
  )									\
"									;	
#########################################################################
command=" 								\
  docker swarm join-token manager 2> /dev/null | grep token 		\
" 									;
token_manager="								\
  $(									\
    send_wait_targets "$command" $sleep $stack "$targets"		\
  )									\
"									;	
#########################################################################
targets=" InstanceMaster2 InstanceMaster3 " 				;
#########################################################################
service_wait_targets $service $sleep $stack "$targets"			;
#########################################################################
command=" $token_manager 2> /dev/null " 				;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
targets=" InstanceWorker1 InstanceWorker2 InstanceWorker3 " 		;
#########################################################################
service_wait_targets $service $sleep $stack "$targets"			;
#########################################################################
command=" $token_worker 2> /dev/null " 					;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
