FROM openshift/base-centos7

LABEL io.k8s.description="Simple HTTP Server" \
      io.k8s.display-name="Simple HTTP Server" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,http"

RUN echo " -----> Install Go language specific binaries" \
    && cd /tmp && curl -O https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz

COPY scripts/assemble /usr/libexec/s2i/
COPY scripts/run /usr/libexec/s2i/
COPY scripts/usage /usr/libexec/s2i/

EXPOSE 8080
USER 1001
CMD [ "/usr/libexec/s2i/usage" ]
