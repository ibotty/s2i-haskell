FROM openshift/base-centos7
MAINTAINER Tobias Florek <tob@butter.sh>

ENV STACK_REPO_URL=https://copr.fedorainfracloud.org/coprs/petersen/stack/repo/epel-7/petersen-stack-epel-7.repo 

LABEL io.k8s.description="Platform for building haskell applications" \
      io.k8s.display-name="haskell builder" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,haskell"

RUN curl -sSL https://s3.amazonaws.com/download.fpcomplete.com/centos/7/fpco.repo \
        -o /etc/yum.repos.d/fpco.repo \
 && yum install -y stack \
 && yum clean all -y

COPY ./.s2i/bin/ ${STI_SCRIPTS_PATH}

RUN chown -R 1001:1001 /opt/app-root

USER 1001

RUN stack setup

EXPOSE 8080

CMD ["usage"]
