#!/bin/bash -x
#	./bin/cluster-kubernetes-manager.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"                || exit 100                             ;
test -n "$ip_leader"		|| exit 100                             ;
test -n "$kube"		        || exit 100                             ;
test -n "$log"                  || exit 100                             ;
test -n "$token_certificate"    || exit 100                             ;
test -n "$token_discovery"      || exit 100                             ;
test -n "$token_token"       	|| exit 100                             ;
#########################################################################
token_certificate="$(							\
	echo								\
		$token_certificate					\
	|								\
	base64								\
		--decode						\
)"							         	;
token_discovery="$(							\
	echo								\
		$token_discovery					\
	|								\
	base64								\
		--decode						\
)"							         	;
token_token="$(								\
	echo								\
		$token_token						\
	|								\
	base64								\
		--decode						\
)"							         	;
#########################################################################
echo $ip_leader $kube | tee --append /etc/hosts                        	;
#########################################################################
while true								;
do									\
        systemctl							\
		is-enabled						\
			kubelet                               		\
	|								\
	grep enabled       	                                   	\
	&& break							\
                                                                        ;
done									;
#########################################################################
while true								;
do									\
	sleep 10							;
	$token_token                                            	\
		$token_discovery                                        \
		$token_certificate                                      \
		--ignore-preflight-errors				\
			all						\
		2>&1							\
	|								\
	tee $log							\
									;
	grep 'This node has joined the cluster' $log && break		;
done									;
#########################################################################
userID=1001                                                             ;
USER=ssm-user                                                           ;
HOME=/home/$USER                                                        ;
mkdir -p $HOME/.kube                                                    ;
cp /etc/kubernetes/admin.conf $HOME/.kube/config                   	;
chown -R $userID:$userID $HOME                                     	;
echo                                                                    \
        'source <(kubectl completion bash)'                             \
|                                      		                        \
tee --append $HOME/.bashrc                     			        \
                                                                        ;
#########################################################################
sed --in-place 								\
	/$kube/d 							\
	/etc/hosts   		                                  	;
sed --in-place 								\
	/localhost4/s/$/' '$kube/ 					\
	/etc/hosts          				             	;
#########################################################################
