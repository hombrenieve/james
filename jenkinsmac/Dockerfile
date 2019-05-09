FROM codeurjc/forge-jenkins:20180423142446
USER root
# change docker sock permissions after mount
RUN if [ -e /var/run/docker.sock ]; then chown jenkins:jenkins /var/run/docker.sock; fi
